pub fn is_word(s: &str) -> bool {
    regex::Regex::new(r"^\w+$").unwrap().is_match(s)
}
