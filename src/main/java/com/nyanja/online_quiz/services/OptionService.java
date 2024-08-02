package com.nyanja.online_quiz.services;

import com.nyanja.online_quiz.model.Option;
import com.nyanja.online_quiz.model.Question;
import com.nyanja.online_quiz.repositories.OptionRepo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OptionService {

    @Autowired
    private OptionRepo optionRepo;
    //private static final Logger logger = LoggerFactory.getLogger(AttemptService.class);
    private static final Logger logger = (Logger) LogManager.getLogger(OptionService.class);
    public List<Option> getAllOptions() {
        logger.info("Fetching all options");
        return optionRepo.findAll();
    }

    public List<Option> getAllOptionsByQuestion(Question question) {
        logger.info("Getting all options that belong to the same question");
        return optionRepo.findOptionsByQuestion(question);
    }

    public Option getOptionById(long id) {
        logger.info("Getting option by ID");
        return optionRepo.findById(id).orElse(null);
    }

    public Option createOption(Option option) {
        logger.info("Creating Option");
        return optionRepo.save(option);
    }

    public void updateOption(long id, Option option) {
        if (optionRepo.existsById(id)) {
            logger.info("Updating option");
            option.setId(id);
            optionRepo.save(option);
        }
    }

    public void deleteOption(long id) {
        logger.info("Deleting option");
        optionRepo.deleteById(id);
    }

}
