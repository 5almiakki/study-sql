SELECT
    sample_id, dna_sequence, species,
    IF(dna_sequence RLIKE "^ATG", 1, 0) AS has_start,
    IF(dna_sequence RLIKE "TAA$|TAG$|TGA$", 1, 0) AS has_stop,
    IF(dna_sequence RLIKE "ATAT", 1, 0) AS has_atat,
    IF(dna_sequence RLIKE "G{3,}", 1, 0) AS has_ggg
FROM Samples;
