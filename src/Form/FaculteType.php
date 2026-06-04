<?php

namespace App\Form;

use App\Entity\Edition;
use App\Entity\Faculte;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class FaculteType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $editionId = $options['edition_id'];

        $builder
            ->add('nom')
            ->add('universite')
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
            'data_class' => Faculte::class,
            'edition_id' => null,
        ]);
    }
}
