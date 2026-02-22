using System.Collections.ObjectModel;
using System.Windows.Input;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class DatabasesPageViewModel : BaseViewModel
{
    public ObservableCollection<PaneViewModel> Panes { get; } = new();
    public PlayerBarViewModel PlayerBar { get; } = new();

    private string _searchText = string.Empty;
    public string SearchText
    {
        get => _searchText;
        set { _searchText = value; OnPropertyChanged(); }
    }

    public ICommand RefreshCommand { get; }
    public ICommand SearchCommand { get; }

    public DatabasesPageViewModel()
    {
        var hybridPane = new HybridPaneViewModel();
        hybridPane.PropertyChanged += (s, e) =>
        {
            if (e.PropertyName == nameof(PaneViewModel.SelectedItem))
                OnHybridPaneSelectionChanged(hybridPane);
        };
        Panes.Add(hybridPane);

        RefreshCommand = new Command(async () =>
        {
            IsBusy = true;
            await Task.Delay(500);
            IsBusy = false;
        });

        SearchCommand = new Command(() => { /* filter logic */ });
    }

    private void OnHybridPaneSelectionChanged(HybridPaneViewModel hybridPane)
    {
        // Remove all panes after the first one (column-browser pattern)
        while (Panes.Count > 1)
            Panes.RemoveAt(Panes.Count - 1);

        if (hybridPane.SelectedItem is { } item)
        {
            var detailsPane = new DatabaseDetailsPaneViewModel(item.Name);
            detailsPane.PropertyChanged += (s, e) =>
            {
                if (e.PropertyName == nameof(PaneViewModel.SelectedItem))
                    OnDetailsPaneSelectionChanged(detailsPane);
            };
            Panes.Add(detailsPane);
        }
    }

    private void OnDetailsPaneSelectionChanged(DatabaseDetailsPaneViewModel detailsPane)
    {
        // Remove all panes after the second one
        while (Panes.Count > 2)
            Panes.RemoveAt(Panes.Count - 1);

        if (detailsPane.SelectedItem is { } item)
            Panes.Add(new FileDetailsPaneViewModel(item.Name));
    }
}
