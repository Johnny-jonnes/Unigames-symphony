<?php

namespace App\Entity;

use App\Repository\MatchGameRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: MatchGameRepository::class)]
#[ORM\Table(name: 'matchs')]
class MatchGame
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $date_match = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $lieu = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $phase = null;

    #[ORM\Column(options: ['default' => 0])]
    private ?int $score_a = 0;

    #[ORM\Column(options: ['default' => 0])]
    private ?int $score_b = 0;

    #[ORM\Column(length: 50)]
    private ?string $statut = 'planifie'; // 'planifie', 'en_cours', 'joue'

    #[ORM\Column(type: Types::JSON, nullable: true)]
    private ?array $buteurs = [];

    #[ORM\ManyToOne(inversedBy: 'matchsAsEquipeA')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Equipe $equipeA = null;

    #[ORM\ManyToOne(inversedBy: 'matchsAsEquipeB')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Equipe $equipeB = null;

    #[ORM\ManyToOne(inversedBy: 'matchs')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Discipline $discipline = null;

    #[ORM\ManyToOne(inversedBy: 'matchs')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Edition $edition = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateMatch(): ?\DateTimeInterface
    {
        return $this->date_match;
    }

    public function setDateMatch(\DateTimeInterface $date_match): static
    {
        $this->date_match = $date_match;
        return $this;
    }

    public function getLieu(): ?string
    {
        return $this->lieu;
    }

    public function setLieu(?string $lieu): static
    {
        $this->lieu = $lieu;
        return $this;
    }

    public function getPhase(): ?string
    {
        return $this->phase;
    }

    public function setPhase(?string $phase): static
    {
        $this->phase = $phase;
        return $this;
    }

    public function getScoreA(): ?int
    {
        return $this->score_a;
    }

    public function setScoreA(int $score_a): static
    {
        $this->score_a = $score_a;
        return $this;
    }

    public function getScoreB(): ?int
    {
        return $this->score_b;
    }

    public function setScoreB(int $score_b): static
    {
        $this->score_b = $score_b;
        return $this;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(string $statut): static
    {
        $this->statut = $statut;
        return $this;
    }

    public function getButeurs(): ?array
    {
        return $this->buteurs;
    }

    /**
     * Gère intelligemment les données doublement encodées en JSON
     * et retourne un tableau toujours itérable.
     */
    public function getDecodedButeurs(): array
    {
        $data = $this->buteurs;
        
        if (empty($data)) {
            return ['equipe_a' => [], 'equipe_b' => []];
        }

        // Si c'est un tableau contenant une chaîne JSON en premier élément (ex: ["{\"equipe_a\":...}"])
        if (is_array($data) && count($data) === 1 && is_string(reset($data))) {
            $data = reset($data);
        }

        // Si c'est une chaîne, on la décode
        if (is_string($data)) {
            $decoded = json_decode($data, true);
            if (json_last_error() === JSON_ERROR_NONE) {
                $data = $decoded;
            } else {
                return ['equipe_a' => [], 'equipe_b' => []]; // Fallback si JSON invalide
            }
        }

        // Si ça a été doublement encodé et qu'on a encore une chaîne (ex: "{\"equipe_a\":...}")
        if (is_string($data)) {
            $decoded = json_decode($data, true);
            if (json_last_error() === JSON_ERROR_NONE) {
                $data = $decoded;
            }
        }

        if (!is_array($data)) {
            return ['equipe_a' => [], 'equipe_b' => []];
        }

        return [
            'equipe_a' => $data['equipe_a'] ?? [],
            'equipe_b' => $data['equipe_b'] ?? []
        ];
    }

    public function setButeurs(?array $buteurs): static
    {
        $this->buteurs = $buteurs;
        return $this;
    }

    public function getEquipeA(): ?Equipe
    {
        return $this->equipeA;
    }

    public function setEquipeA(?Equipe $equipeA): static
    {
        $this->equipeA = $equipeA;
        return $this;
    }

    public function getEquipeB(): ?Equipe
    {
        return $this->equipeB;
    }

    public function setEquipeB(?Equipe $equipeB): static
    {
        $this->equipeB = $equipeB;
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
}
