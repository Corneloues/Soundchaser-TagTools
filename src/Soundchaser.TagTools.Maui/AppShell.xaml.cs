using Soundchaser.TagTools.Maui.Views;

namespace Soundchaser.TagTools.Maui;

public partial class AppShell : Shell
{
    public AppShell()
    {
        InitializeComponent();
        Routing.RegisterRoute(nameof(SettingsPage), typeof(SettingsPage));
    }

    public System.Windows.Input.ICommand GoToSettingsCommand =>
        new Command(async () => await Shell.Current.GoToAsync(nameof(SettingsPage)));
}
