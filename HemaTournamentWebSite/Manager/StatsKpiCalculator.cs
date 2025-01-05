using HemaTournamentWebSite.DAL.DAL.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2.Manager
{
    public class StatsKpiCalculator
    {
        public Stats bestDelta;
        public Stats mostVictories;
        public Stats bestWinRate;
        public double winRate;
        public Stats mostPointsHit;
        public Stats leastPointsHitted;
        public Stats bestRanking;
        public double avgDelta;
        public Stats bestWinLossRatioNoLoss;
        public Stats bestWinLossRatioLoss;
        public double winLossRatio;
        public Stats mostEfficient;
        public double efficiency;

        public StatsKpiCalculator(List<Stats> statsList)
        {
            // 1. Miglior Delta
            bestDelta = statsList.OrderByDescending(s => s.Delta).FirstOrDefault();
            Console.WriteLine($"Miglior Delta: {bestDelta?.Name} {bestDelta?.Delta}");

            // 2. Maggior Numero di Vittorie
            mostVictories = statsList.OrderByDescending(s => s.Victory).FirstOrDefault();
            Console.WriteLine($"Maggior Numero di Vittorie: {mostVictories?.Name} {mostVictories?.Victory}");

            // 3. Miglior Percentuale di Vittorie
            bestWinRate = statsList
                .Where(s => s.Victory + s.Loss > 0)
                .OrderByDescending(s => (double)s.Victory / (s.Victory + s.Loss))
                .FirstOrDefault();
            winRate = bestWinRate != null ? (double)bestWinRate.Victory / (bestWinRate.Victory + bestWinRate.Loss) * 100 : 0;
            Console.WriteLine($"Miglior Percentuale di Vittorie: {bestWinRate?.Name} {winRate:F2}%");

            // 4. Maggior Numero di Punti Fatti
            mostPointsHit = statsList.OrderByDescending(s => s.Hit).FirstOrDefault();
            Console.WriteLine($"Maggior Numero di Punti Fatti: {mostPointsHit?.Name} {mostPointsHit?.Hit}");

            // 5. Minor Numero di Punti Subiti
            leastPointsHitted = statsList.OrderBy(s => s.Hitted).FirstOrDefault();
            Console.WriteLine($"Minor Numero di Punti Subiti: {leastPointsHitted?.Name} {leastPointsHitted?.Hitted}");

            // 6. Miglior Ranking
            bestRanking = statsList.FirstOrDefault();
            Console.WriteLine($"Miglior Ranking: {bestRanking?.Name} {bestRanking?.Ranking}");

            // 7. Media Delta
            avgDelta = statsList.Average(s => s.Delta);
            Console.WriteLine($"Delta Medio: {avgDelta:F2}");

            // 8. Rapporto Vittorie/Sconfitte
            bestWinLossRatioNoLoss = statsList
                .Where(s => s.Loss == 0)
                //.OrderByDescending(s => (double)s.Victory / s.Loss)
                .FirstOrDefault();

            bestWinLossRatioLoss = statsList
                .Where(s => s.Loss > 0)
                .OrderByDescending(s => (double)s.Victory / s.Loss)
                .FirstOrDefault();


            winLossRatio = bestWinLossRatioNoLoss != null ? (double)bestWinLossRatioNoLoss.Victory :
                bestWinLossRatioLoss != null ? (double)bestWinLossRatioLoss.Victory / bestWinLossRatioLoss.Loss : 0
                ;
            Console.WriteLine($"Miglior Rapporto Vittorie/Sconfitte: {bestWinLossRatioLoss?.Name} {winLossRatio:F2}");

            // 9. Efficienza Punti
            mostEfficient = statsList
                .Where(s => s.Hit + s.Hitted > 0)
                .OrderByDescending(s => (double)s.Hit / (s.Hit + s.Hitted))
                .FirstOrDefault();
            efficiency = mostEfficient != null ? (double)mostEfficient.Hit / (mostEfficient.Hit + mostEfficient.Hitted) * 100 : 0;
            Console.WriteLine($"Efficienza Punti: {mostEfficient?.Name} {efficiency:F2}%");
        }
    }
}