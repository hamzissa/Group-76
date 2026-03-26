package com.example.group76.model;

import jakarta.persistence.*;

@Entity
@Table(name = "badges")
public class Badge {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false)
	private String name;

	@Column(nullable = false)
	private String description;

	@Column(nullable = false)
	private int requiredXp;

	@Column(nullable = false)
	private String icon;

	@Column(nullable = false)
	private String imagePath;

	public Badge() {
	}

	// Constructor to create a new badge with all details
	public Badge(String name, String description, int requiredXp, String icon, String imagePath) {
		this.name = name;
		this.description = description;
		this.requiredXp = requiredXp;
		this.icon = icon;
		this.imagePath = imagePath;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getRequiredXp() {
		return requiredXp;
	}

	public void setRequiredXp(int requiredXp) {
		this.requiredXp = requiredXp;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
}
