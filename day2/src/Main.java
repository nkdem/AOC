import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.*;
public class Main {
        public static void main(String[] args) {
            String pathname = "day2/inputs/2";
            try {
                List<List<Move>> input = readNumbers(new FileInputStream(new File(pathname)));
                System.out.println(input);
                Integer total = solve1(input);
                System.out.println(total);
                System.out.println(solve2(input));
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    public static Integer solve1(List<List<Move>> list) {
        int sum = 0;
        for (List<Move> round:list) {
            Move opponenentMove = round.get(0);
            Move myMove = round.get(1);
            if (opponenentMove == myMove) { // DRAW
                sum += 3 + myMove.getScore();
            }
            else if (opponenentMove.winsAgainst() == myMove) { // LOSE
                sum += myMove.getScore();
            }
            else {
                sum += 6 + myMove.getScore();
            }
        }

        return sum;
    }

    public static Integer solve2(List<List<Move>> list) {
        for (int i=0; i < list.size(); i++) {
            Move opponenentMove = list.get(i).get(0);
            Move myMove = list.get(i).get(1);
            list.get(i).set(1, opponenentMove.decode(myMove.getValue()));
        }
        System.out.println(list);
            return solve1(list);
    }
        public static List<List<Move>> readNumbers(FileInputStream in) {
            Scanner scan = new Scanner(in);
            List<List<Move>> rounds = new ArrayList<>();
            while (scan.hasNext()) {
                String line = scan.nextLine();
                Move opponent = Move.get(line.charAt(0));
                Move myMove = Move.get(line.charAt(2));
                rounds.add(new ArrayList<>(Arrays.asList(opponent, myMove)));
            }
            return rounds;
        }
    }

   enum Move {
    ROCK('A', 1), PAPER('B', 2), SCISSORS('C', 3);
    private final char value;
    private final int score;

    static final char[] keys = {'\0', 'A', 'B','C'};

    private static final Map<Character, Move> ENUM_MAP;

    static {
        HashMap<Character, Move> map = new HashMap<>();
        for (Move instance : Move.values()) {
            map.put(instance.getValue(), instance);
        }
        ENUM_MAP = Collections.unmodifiableMap(map);
    }

    public Move winsAgainst() {
        return switch (this) {
            case ROCK -> SCISSORS;
            case PAPER -> ROCK;
            case SCISSORS -> PAPER;
        };
    }

    public static Move get(char from) {
        switch (from) {
            case 'X':
                from = 'A';
                break;
            case 'Y':
                from = 'B';
                break;
            case 'Z':
                from = 'C';
                break;
        }
        return ENUM_MAP.get(from);
    }

    public Move decode(char from) {
        return switch (from) {
          case 'A' -> this.winsAgainst() ;
          case 'B' -> this;
          case 'C' -> Move.get(keys[this.getScore() == 2 ? Math.abs(this.getScore() + this.winsAgainst().getScore()) : Math.abs(this.getScore() - this.winsAgainst().getScore())]);
          default -> null;
        };
    }

    Move(char value, int score) {
        this.value = value;
        this.score = score;
    }

    public char getValue() {
        return value;
    }

    public int getScore() {
        return score;
    }
}