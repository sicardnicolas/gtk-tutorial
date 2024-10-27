/* application.vala
 *
 * Copyright 2024 nico
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class TextViewer.Application : Adw.Application {
    private Settings settings = new Settings ("com.example.TextViewer");

    public Application () {
        Object (
            application_id: "com.example.TextViewer",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    construct {
        bool dark_mode = this.settings.get_boolean ("dark-mode");
        var style_manager = Adw.StyleManager.get_default ();
        if (dark_mode)
            style_manager.color_scheme = Adw.ColorScheme.FORCE_DARK;
        else
            style_manager.color_scheme = Adw.ColorScheme.DEFAULT;

        var dark_mode_action = new SimpleAction.stateful ("dark-mode", null, new Variant.boolean (dark_mode));

        dark_mode_action.activate.connect (this.toggle_dark_mode);
        dark_mode_action.change_state.connect (this.change_color_scheme);

        ActionEntry[] action_entries = {
            { "about", this.on_about_action },
            { "preferences", this.on_preferences_action },
            { "quit", this.quit }
        };
        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", {"<primary>q"});

        this.set_accels_for_action("win.open", {"<Ctrl>o"});

        this.set_accels_for_action("win.save-as", { "<Ctrl><Shift>s" });
    }

    private void toggle_dark_mode (Action action, Variant? parameter) {
        Variant state = action.state;
        bool old_state = state.get_boolean ();
        bool new_state = !old_state;
        action.change_state (new_state);
    }

    private void change_color_scheme (SimpleAction action, Variant? new_state) {
        bool dark_mode = new_state.get_boolean ();
        var style_manager = Adw.StyleManager.get_default ();

        if (dark_mode)
            style_manager.color_scheme = Adw.ColorScheme.FORCE_DARK;
        else
            style_manager.color_scheme = Adw.ColorScheme.DEFAULT;
        action.set_state (new_state);

        this.settings.set_boolean ("dark-mode", dark_mode);
    }

    public override void activate () {
        base.activate ();
        var win = this.active_window ?? new TextViewer.Window (this);
        win.present ();
    }

    private void on_about_action () {
        string[] developers = { "nico" };
        var about = new Adw.AboutDialog () {
            application_name = "text-viewer",
            application_icon = "com.example.TextViewer",
            developer_name = "nico",
            translator_credits = _("translator-credits"),
            version = "0.1.0",
            developers = developers,
            copyright = "© 2024 nico",
        };

        about.present (this.active_window);
    }

    private void on_preferences_action () {
        message ("app.preferences action activated");
    }
}
