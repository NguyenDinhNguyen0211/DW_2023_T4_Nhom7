import module.Schema;

public class App {
    public static void main(String[] args) throws Exception {
        for (String arg : args)
            new Schema().run(arg);
    }
}
