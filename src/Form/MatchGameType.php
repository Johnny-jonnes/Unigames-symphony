<?php

namespace App\Form;

use App\Entity\Discipline;
use App\Entity\Edition;
use App\Entity\Equipe;
use App\Entity\MatchGame;
use Doctrine\ORM\EntityRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class MatchGameType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $editionId = $options['edition_id'];

        $equipeQueryBuilder = $editionId ? function (EntityRepository $er) use ($editionId) {
            return $er->createQueryBuilder('e')
                ->where('e.edition = :edition')
                ->setParameter('edition', $editionId)
                ->orderBy('e.nom', 'ASC');
        } : null;

        $builder
            ->add('date_match')
            ->add('lieu')
            ->add('phase')
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
            ->add('equipeA', EntityType::class, [
                'class' => Equipe::class,
                'choice_label' => 'nom',
                'query_builder' => $equipeQueryBuilder,
                'choice_attr' => function(Equipe $equipe, $key, $value) {
                    return ['data-discipline' => $equipe->getDiscipline()->getId()];
                },
            ])
            ->add('equipeB', EntityType::class, [
                'class' => Equipe::class,
                'choice_label' => 'nom',
                'query_builder' => $equipeQueryBuilder,
                'choice_attr' => function(Equipe $equipe, $key, $value) {
                    return ['data-discipline' => $equipe->getDiscipline()->getId()];
                },
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
            'data_class' => MatchGame::class,
            'edition_id' => null,
        ]);
    }
}
