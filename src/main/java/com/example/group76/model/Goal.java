package com.example.group76.model;

import jakarta.persistence.*;

@Entity
@Table(name = "goals")
public class Goal {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private int target;
    private int completedCount;
    private String timeframe;
    private String reward;
    private boolean active;

    public Goal() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public int getTarget() { return target; }
    public void setTarget(int target) { this.target = target; }
    public int getCompletedCount() { return completedCount; }
    public void setCompletedCount(int completedCount) { this.completedCount = completedCount; }
    public String getTimeframe() { return timeframe; }
    public void setTimeframe(String timeframe) { this.timeframe = timeframe; }
    public String getReward() { return reward; }
    public void setReward(String reward) { this.reward = reward; }
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}