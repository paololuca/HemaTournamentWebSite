using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HemaTournamentWebSite
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Percorso fisico della directory (modifica con il tuo percorso)
            string imagePath = Server.MapPath("~/assets/img/About/");

            // Ottieni tutti i file immagine con estensione .jpg
            List<string> imageFiles = Directory.GetFiles(imagePath, "*.jpg").ToList();
            List<int> usedIndexes = new List<int>(); // Per tenere traccia degli indici già usati

            if (imageFiles.Count > 0)
            {
                // Genera un indice casuale
                Random random = new Random();

                img1.Src = GetrandomImage(imageFiles, usedIndexes, random);
                img2.Src = GetrandomImage(imageFiles, usedIndexes, random);
                img3.Src = GetrandomImage(imageFiles, usedIndexes, random);
                img4.Src = GetrandomImage(imageFiles, usedIndexes, random);
            }
            else
            {
                
            }
        }

        private string GetrandomImage(List<string> imageFiles, List<int> usedIndexes, Random random)
        {
            int selectedIndex = -1;

            do
            {
                selectedIndex = random.Next(1, imageFiles.Count+1);
            } while (usedIndexes.Contains(selectedIndex) && usedIndexes.Count < imageFiles.Count);

            // Aggiungi l'indice selezionato agli usati
            usedIndexes.Add(selectedIndex);

            // Imposta l'attributo "src" dell'immagine
            return $"~/assets/img/About/About{selectedIndex}.jpg";
        }

    }
}