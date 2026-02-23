using System.Globalization;
using System.Resources;

namespace Soundchaser.TagTools.Maui.Resources.Strings;

/// <summary>
/// Provides XAML-accessible (<c>x:Static</c>) properties for all user-facing strings.
/// Strings are read from the embedded RESX and respect <see cref="CultureInfo.CurrentUICulture"/>.
/// </summary>
public static class AppStrings
{
    private static readonly ResourceManager _resourceManager =
        new("Soundchaser.TagTools.Maui.Resources.Strings.AppStrings",
            typeof(AppStrings).Assembly);

    private static string Get(string key) =>
        _resourceManager.GetString(key, CultureInfo.CurrentUICulture) ?? key;

    // Flyout navigation
    public static string FlyoutDatabases       => Get(nameof(FlyoutDatabases));
    public static string FlyoutPlaylists       => Get(nameof(FlyoutPlaylists));
    public static string FlyoutHistory         => Get(nameof(FlyoutHistory));
    public static string FlyoutSettings        => Get(nameof(FlyoutSettings));

    // Toolbar actions
    public static string ToolbarScan           => Get(nameof(ToolbarScan));
    public static string ToolbarRefresh        => Get(nameof(ToolbarRefresh));
    public static string ToolbarFixReferences  => Get(nameof(ToolbarFixReferences));
    public static string ToolbarReplaceQuality => Get(nameof(ToolbarReplaceQuality));
    public static string ToolbarFilters        => Get(nameof(ToolbarFilters));
    public static string ToolbarCancel         => Get(nameof(ToolbarCancel));

    // Search bar
    public static string SearchPlaceholder     => Get(nameof(SearchPlaceholder));

    // Busy / progress labels (use with string.Format(CultureInfo.CurrentUICulture, ...))
    public static string BusyScanning          => Get(nameof(BusyScanning));
    public static string BusyRefreshing        => Get(nameof(BusyRefreshing));

    // Pane titles
    public static string PaneTitleDatabases        => Get(nameof(PaneTitleDatabases));
    public static string PaneTitleDatabaseDetails  => Get(nameof(PaneTitleDatabaseDetails));
    public static string PaneTitleFileDetails      => Get(nameof(PaneTitleFileDetails));

    // File details labels
    public static string FileDetailsType           => Get(nameof(FileDetailsType));
    public static string FileDetailsDuration       => Get(nameof(FileDetailsDuration));
    public static string FileDetailsCodec          => Get(nameof(FileDetailsCodec));
    public static string FileDetailsBitrate        => Get(nameof(FileDetailsBitrate));
    public static string FileDetailsLastSeen       => Get(nameof(FileDetailsLastSeen));
    public static string FileDetailsPlaylists      => Get(nameof(FileDetailsPlaylists));
    public static string FileDetailsRevealInFolder => Get(nameof(FileDetailsRevealInFolder));
    public static string FileDetailsFixReplace     => Get(nameof(FileDetailsFixReplace));

    // Player controls
    public static string PlayerPlay                => Get(nameof(PlayerPlay));
    public static string PlayerPause               => Get(nameof(PlayerPause));
    public static string PlayerStop                => Get(nameof(PlayerStop));
    public static string PlayerNoSelection         => Get(nameof(PlayerNoSelection));
    public static string PlayerSelectFile          => Get(nameof(PlayerSelectFile));

    // Page titles and placeholder text
    public static string DatabasesPageTitle        => Get(nameof(DatabasesPageTitle));
    public static string HistoryPageTitle          => Get(nameof(HistoryPageTitle));
    public static string HistoryComingSoon         => Get(nameof(HistoryComingSoon));
    public static string PlaylistsPageTitle        => Get(nameof(PlaylistsPageTitle));
    public static string PlaylistsComingSoon       => Get(nameof(PlaylistsComingSoon));
    public static string SettingsPageTitle         => Get(nameof(SettingsPageTitle));
    public static string SettingsComingSoon        => Get(nameof(SettingsComingSoon));
}
