<?php

namespace App\Form;

use App\Entity\Equipe;
use App\Entity\Joueur;
use Doctrine\ORM\EntityRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class JoueurType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $editionId = $options['edition_id'];

        $builder
            ->add('nom')
            ->add('prenom')
            ->add('sexe', ChoiceType::class, [
                'choices' => [
                    'Masculin' => 'M',
                    'Féminin' => 'F',
                ],
            ])
            ->add('numero')
            ->add('discipline', EntityType::class, [
                'class' => \App\Entity\Discipline::class,
                'choice_label' => 'nom',
                'mapped' => false,
                'required' => false,
                'placeholder' => 'Sélectionnez une discipline...',
                'query_builder' => $editionId ? function (EntityRepository $er) use ($editionId) {
                    return $er->createQueryBuilder('d')
                        ->where('d.edition = :edition')
                        ->setParameter('edition', $editionId)
                        ->orderBy('d.nom', 'ASC');
                } : null,
            ])
            ->add('equipe', EntityType::class, [
                'class' => Equipe::class,
                'choice_label' => 'nom',
                'query_builder' => $editionId ? function (EntityRepository $er) use ($editionId) {
                    return $er->createQueryBuilder('e')
                        ->where('e.edition = :edition')
                        ->setParameter('edition', $editionId)
                        ->orderBy('e.nom', 'ASC');
                } : null,
                'choice_attr' => function(Equipe $equipe, $key, $value) {
                    return ['data-discipline' => $equipe->getDiscipline()->getId()];
                },
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Joueur::class,
            'edition_id' => null,
        ]);
    }
}
