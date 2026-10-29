WITH query AS (
    SELECT
        eco.[disclosure_id] AS disclosure_id
        ,d.[org_id] AS org_id
        ,d.[disclosure_cycle_id] + 2023 AS year
        ,eco.[themes] AS theme
        ,s.[name] AS sector
        ,eco.[pass] AS pass
        ,eco.[is_used_in_decision] AS is_used_in_decision
        ,eco.[essential_criteria_name] AS name
        ,eco.[essential_criteria_grade] AS grade
        ,CASE
            WHEN eco.[essential_criteria_grade] = 'A' THEN 'A-List'
            WHEN eco.[essential_criteria_grade] = 'A-' THEN 'Leadership'
            WHEN eco.[essential_criteria_grade] = 'B-' THEN 'Management'
            WHEN eco.[essential_criteria_grade] = 'C-' THEN 'Awareness'
            ELSE 'Hmmmm'
        END AS level
        ,eco.[essential_criteria_type] AS type
        ,q.[version] AS version
        ,eco.[is_all_themes] AS is_all_themes
        ,eco.[is_latest] AS is_latest
    FROM
        [dbo].[essential_criteria_outcome] AS eco
    LEFT JOIN [dbo].[disclosure] AS d
        ON d.[id]=eco.[disclosure_id]
    LEFT JOIN [dbo].[sector] AS s
        ON s.[id]=d.[sector_id]
    LEFT JOIN [dbo].[questionnaire] AS q
        ON eco.[questionnaire_id] = q.[id]
    WHERE 1=1
        AND d.[is_latest] = 1
)
SELECT
    *
FROM
    query
WHERE 1=1
AND year = 2026
AND is_latest = 1
AND org_id = 2010458
AND theme = 'Water'