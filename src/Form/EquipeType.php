<?php

namespace App\Form;

use App\Entity\Discipline;
use App\Entity\Edition;
use App\Entity\Equipe;
use App\Entity\Faculte;
use Doctrine\ORM\EntityRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class EquipeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $editionId = $options['edition_id'];

        $builder
            ->add('nom')
            ->add('faculte', EntityType::class, [
                'class' => Faculte::class,
                'choice_label' => 'nom',
                'query_builder' => $editionId ? function (EntityRepository $er) use ($editionId) {
                    return $er->createQueryBuilder('f')
                        ->where('f.edition = :edition')
                        ->setParameter('edition', $editionId)
                        ->orderBy('f.nom', 'ASC');
                } : null,
            ])
            ->add('discipline', EntityType::class, [
                'class' => Discipline::class,
                'choice_label' => 'nom',
                'query_builder' => $editionId ? function (EntityRepository $er) use ($editionId) {
                    return $er->createQueryBuilder('d')
                        ->where('d.edition = :edition')
                        ->setParameter('edition', $editionId)
                        ->orderBy('d.nom', 'ASC');
                } : null,
            ])
            ->add('edition', EntityType::class, [
                'class' => Edition::class,
                'choice_label' => 'nom',
                'disabled' => (bool) $editionId,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Equipe::class,
            'edition_id' => null,
        ]);
    }
}
