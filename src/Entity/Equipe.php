<?php

namespace App\Entity;

use App\Repository\EquipeRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: EquipeRepository::class)]
class Equipe
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $nom = null;

    #[ORM\ManyToOne(inversedBy: 'equipes')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Faculte $faculte = null;

    #[ORM\ManyToOne(inversedBy: 'equipes')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Discipline $discipline = null;

    #[ORM\ManyToOne(inversedBy: 'equipes')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Edition $edition = null;

    #[ORM\OneToMany(mappedBy: 'equipe', targetEntity: Joueur::class)]
    private Collection $joueurs;

    #[ORM\OneToMany(mappedBy: 'equipeA', targetEntity: MatchGame::class)]
    private Collection $matchsAsEquipeA;

    #[ORM\OneToMany(mappedBy: 'equipeB', targetEntity: MatchGame::class)]
    private Collection $matchsAsEquipeB;

    public function __construct()
    {
        $this->joueurs = new ArrayCollection();
        $this->matchsAsEquipeA = new ArrayCollection();
        $this->matchsAsEquipeB = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): static
    {
        $this->nom = $nom;
        return $this;
    }

    public function getFaculte(): ?Faculte
    {
        return $this->faculte;
    }

    public function setFaculte(?Faculte $faculte): static
    {
        $this->faculte = $faculte;
        return $this;
    }

    public function getDiscipline(): ?Discipline
    {
        return $this->discipline;
    }

    public function setDiscipline(?Discipline $discipline): static
    {
        $this->discipline = $discipline;
        return $this;
    }

    public function getEdition(): ?Edition
    {
        return $this->edition;
    }

    public function setEdition(?Edition $edition): static
    {
        $this->edition = $edition;
        return $this;
    }

    /**
     * @return Collection<int, Joueur>
     */
    public function getJoueurs(): Collection
    {
        return $this->joueurs;
    }

    /**
     * @return Collection<int, MatchGame>
     */
    public function getMatchsAsEquipeA(): Collection
    {
        return $this->matchsAsEquipeA;
    }

    /**
     * @return Collection<int, MatchGame>
     */
    public function getMatchsAsEquipeB(): Collection
    {
        return $this->matchsAsEquipeB;
    }

    // --- Logique métier (calculs à la volée) ---

    public function getPoints(): int
    {
        $points = 0;
        foreach ($this->getAllMatchs() as $match) {
            if ($match->getStatut() !== 'joue') continue;

            if ($match->getEquipeA() === $this) {
                if ($match->getScoreA() > $match->getScoreB()) $points += 3;
                elseif ($match->getScoreA() === $match->getScoreB()) $points += 1;
            } else {
                if ($match->getScoreB() > $match->getScoreA()) $points += 3;
                elseif ($match->getScoreA() === $match->getScoreB()) $points += 1;
            }
        }
        return $points;
    }

    /**
     * @return MatchGame[]
     */
    public function getAllMatchs(): array
    {
        return array_merge($this->matchsAsEquipeA->toArray(), $this->matchsAsEquipeB->toArray());
    }

    public function getMatchsJoues(): int
    {
        return count(array_filter($this->getAllMatchs(), fn($m) => $m->getStatut() === 'joue'));
    }
}
