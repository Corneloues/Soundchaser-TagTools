using Soundchaser.TagTools.Maui.Resources.Strings;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class PlayerBarViewModel : BaseViewModel
{
    private string _trackTitle = AppStrings.PlayerNoSelection;
    public string TrackTitle
    {
        get => _trackTitle;
        set { _trackTitle = value; OnPropertyChanged(); }
    }

    private double _progress;
    public double Progress
    {
        get => _progress;
        set { _progress = value; OnPropertyChanged(); }
    }

    private bool _isPlaying;
    public bool IsPlaying
    {
        get => _isPlaying;
        set { _isPlaying = value; OnPropertyChanged(); }
    }
}
