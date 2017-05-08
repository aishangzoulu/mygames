package com.raymond.game.service;

import com.raymond.core.generic.GenericService;

import java.util.List;

public interface EightDigitalService extends GenericService<String, String> {
	public List<String> getImages(String id);

	public String getResult(String id);
}
