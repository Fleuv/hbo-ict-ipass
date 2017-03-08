package model;

import java.util.ArrayList;

public class Review {

    /**
     * Attributes
     * ------------
     */

    private Level level;
    private User user;
    private String feedback;
    private double graphicRating;
    private double technicalRating;
    private double[] gametypeRatings;


    /**
     * Constructors
     * ------------
     */

    public Review(Level level, User user, String feedback, double graphicRating, double technicalRating, double[] gametypeRatings) {
        this.level = level;
        this.user = user;
        this.feedback = feedback;
        this.graphicRating = graphicRating;
        this.technicalRating = technicalRating;
        this.gametypeRatings = gametypeRatings;
    }


    /**
     * Getters
     * ------------
     */

    public Level getLevel() {
        return level;
    }

    public User getUser() {
        return user;
    }

    public String getFeedback() {
        return feedback;
    }

    public double getGraphicRating() {
        return graphicRating;
    }

    public double getTechnicalRating() {
        return technicalRating;
    }

    public double[] getGametypeRatings() {
        return gametypeRatings;
    }


    /**
     * Setters
     * ------------
     */

    public void setLevel(Level level) {
        this.level = level;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public void setGraphicRating(double graphicRating) {
        this.graphicRating = graphicRating;
    }

    public void setTechnicalRating(double technicalRating) {
        this.technicalRating = technicalRating;
    }

    public void setGametypeRatings(double[] gametypeRatings) {
        this.gametypeRatings = gametypeRatings;
    }
}
