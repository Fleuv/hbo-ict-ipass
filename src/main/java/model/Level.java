package model;

public class Level {

    /**
     * Attributes
     * ------------
     */

    private String filename;
    private String title;
    private String description;
    private String version;
    private String previousVersion;
    private String[] games;
    private String[] gametypes;
    private User user;


    /**
     * Constructors
     * ------------
     */

    public Level(String filename, String title, String description, String version, String previousVersion, String[] games, String[] gametypes, User user) {
        this.filename = filename;
        this.title = title;
        this.description = description;
        this.version = version;
        this.previousVersion = previousVersion;
        this.games = games;
        this.gametypes = gametypes;
        this.user = user;
    }


    /**
     * Getters
     * ------------
     */

    public String getTitle() {
        return title;
    }

    public String getFilename() {
        return filename;
    }

    public String getDescription() {
        return description;
    }

    public User getUser() {
        return user;
    }

    public String getVersion() {
        return version;
    }

    public String getPreviousVersion() {
        return previousVersion;
    }

    public String[] getGames() {
        return games;
    }

    public String[] getGametypes() {
        return gametypes;
    }


    /**
     * Setters
     * ------------
     */

    public void setTitle(String title) {
        this.title = title;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public void setPreviousVersion(String previousVersion) {
        this.previousVersion = previousVersion;
    }

    public void setGames(String[] games) {
        this.games = games;
    }

    public void setGametypes(String[] gametypes) {
        this.gametypes = gametypes;
    }
}
