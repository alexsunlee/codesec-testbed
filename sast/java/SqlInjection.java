package net.lacework.codesec.testbed;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * SAST fixture. Two planted flaws, both reachable from an HTTP handler.
 *   CWE-89  SQL injection      - findUser
 *   CWE-78  OS command injection - exportReport
 * Neither is exploitable here because nothing calls into it; the point is the
 * data flow from parameter to sink, which is what a taint engine must see.
 */
public class SqlInjection {

    /** CWE-89: the parameter is concatenated straight into the statement. */
    public ResultSet findUser(Connection conn, String username) throws Exception {
        Statement stmt = conn.createStatement();
        String sql = "SELECT id, email FROM users WHERE username = '" + username + "'";
        return stmt.executeQuery(sql);
    }

    /** CWE-78: the parameter reaches a shell. */
    public void exportReport(String reportName) throws Exception {
        Runtime.getRuntime().exec("/bin/sh -c 'generate-report " + reportName + "'");
    }

    /** The same query done safely, so a scanner that flags this one is over-reporting. */
    public ResultSet findUserSafely(Connection conn, String username) throws Exception {
        var ps = conn.prepareStatement("SELECT id, email FROM users WHERE username = ?");
        ps.setString(1, username);
        return ps.executeQuery();
    }
}
