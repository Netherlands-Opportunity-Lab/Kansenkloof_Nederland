# Dashboard Netherlands
#
# - text and options for de UI
#
# (c) Erasmus School of Economics 2024

GeoChoices_1 <- list(lang[["label_the_netherlands"]],
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_drenthe"]] & area_dat$type == lang[["label_municipality"]]))), 
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_flevoland"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_friesland"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_gelderland"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_groningen"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_limburg"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_noord_brabant"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_noord_holland"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_overijssel"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_utrecht"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_zeeland"]] & area_dat$type == lang[["label_municipality"]]))),
                   sort(unique(subset(area_dat$gemeente, area_dat$provincie == lang[["label_zuid_holland"]] & area_dat$type == lang[["label_municipality"]])))
                   )

names(GeoChoices_1) <- c("",
                       lang[["geography_label_areas_drenthe"]],
                       lang[["geography_label_areas_flevoland"]],
                       lang[["geography_label_areas_friesland"]], 
                       lang[["geography_label_areas_gelderland"]],
                       lang[["geography_label_areas_groningen"]], 
                       lang[["geography_label_areas_limburg"]], 
                       lang[["geography_label_areas_noord_brabant"]], 
                       lang[["geography_label_areas_noord_holland"]], 
                       lang[["geography_label_areas_overijssel"]],
                       lang[["geography_label_areas_utrecht"]], 
                       lang[["geography_label_areas_zeeland"]], 
                       lang[["geography_label_areas_zuid_holland"]]
                       )

outcomeChoices <- list(
    lang[["health_choices"]], 
    lang[["education_choices"]],
    lang[["money_choices"]],
    lang[["house_choices"]]
)

names(outcomeChoices) <- c(
    lang[["health_catogory_label"]], 
    lang[["education_catogory_label"]],
    lang[["money_catogory_label"]],
    lang[["house_catogory_label"]]
)

faq_q1 <- HTML(paste(str_wrap("Vraag 1: hoe wordt Opleiding Ouders gedefinieerd, 
waarom is het alleen beschikbaar voor een paar uitkomstmaten en waarom zijn er maar drie categorieën?", width = 60), sep = "<br/>"))
faq_a1 <- HTML(paste0("<p>Opleiding ouders wordt gedefinieerd als de hoogst 
                              behaalde opleiding van één van de ouders. Voor opleiding 
                              ouders hebben we drie categorieën: geen wo en hbo, hbo en wo.</p>
                              
                              <p>We kunnen alleen de opleidingen van de ouders bepalen voor de 
                              jongere geboortecohorten (groep 8 en pasgeborenen), omdat de 
                              gegevens over de opleidingen van ouders pas beschikbaar zijn 
                              vanaf 1983 voor wo, 1986 voor hbo en 2004 voor mbo. 
                             Het opleidingsniveau 'geen hbo of wo' kan hierdoor niet verder 
                             gedifferentieerd worden.</p>"))

faq_q2 <- "Vraag 2: waarom is dit de tweede veelgestelde vraag?"
faq_a2 <- "Antwoord op de vraag!"


faq_q3 <- "Vraag 3: waarom is dit de derde veelgestelde vraag?"
faq_a3 <- "Antwoord op de vraag!"

faq_q4 <- "Vraag 4: waarom is dit de vierde veelgestelde vraag?"
faq_a4 <- "Antwoord op de vraag!"

faq_q5 <- "Vraag 5: waarom is dit de vijfde veelgestelde vraag?"
faq_a5 <- "Antwoord op de vraag!"




