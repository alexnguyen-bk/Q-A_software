package com.alexnguyen.interview_software.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
public class TestController {

    @GetMapping("/haha")
    public Map<String, String> hello() {
        return Map.of(
                "status", "Thành công rồi!",
                "message", "Java 25 và Docker đã thông nhau nhé!",
                "port", "8386"
        );
    }
}