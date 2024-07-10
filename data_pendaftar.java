/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package uas_pbo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;
/**
 *
 * @author Romy
 */
public class data_pendaftar extends javax.swing.JFrame {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://127.0.0.1/pendaftar_mhs_baru";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private List<Pendaftaran> pendaftarans;
    /**
     * Creates new form data_pendaftar
     */
    public data_pendaftar() {
        initComponents();
        loadData();
        showPendaftaran();
    }

    private void loadData() {
        pendaftarans = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT * FROM pendaftaran";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String nama = rs.getString("nama");
                double nilai = rs.getDouble("nilai");
                String progdi_id = rs.getString("progdi_id");
                Date tanggal_pendaftaran = rs.getDate("tanggal_pendaftaran");
                String status = rs.getString("status");
                String nim = rs.getString("nim");

                Pendaftaran pendaftaran = new Pendaftaran(id, nama, nilai, progdi_id, tanggal_pendaftaran, status, nim);
                pendaftarans.add(pendaftaran);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to display data in the table
    private void showPendaftaran() {
        PendaftaranTableModel model = new PendaftaranTableModel(pendaftarans);
        jTable1.setModel(model);
    }

    // Custom TableModel for Pendaftaran
    private class PendaftaranTableModel extends AbstractTableModel {
        private final List<Pendaftaran> pendaftarans;
        private final String[] columns = {"ID", "Nama", "Nilai", "Program Studi", "Tanggal Pendaftaran", "Status", "NIM"};

        public PendaftaranTableModel(List<Pendaftaran> pendaftarans) {
            this.pendaftarans = pendaftarans;
        }

        @Override
        public int getRowCount() {
            return pendaftarans.size();
        }

        @Override
        public int getColumnCount() {
            return columns.length;
        }

        @Override
        public String getColumnName(int columnIndex) {
            return columns[columnIndex];
        }

        @Override
        public Object getValueAt(int rowIndex, int columnIndex) {
            Pendaftaran pendaftaran = pendaftarans.get(rowIndex);
            switch (columnIndex) {
                case 0:
                    return pendaftaran.getId();
                case 1:
                    return pendaftaran.getNama();
                case 2:
                    return pendaftaran.getNilai();
                case 3:
                    return pendaftaran.getProgdi_id();
                case 4:
                    return pendaftaran.getTanggal_pendaftaran();
                case 5:
                    return pendaftaran.getStatus();
                case 6:
                    return pendaftaran.getNim();
                default:
                    return null;
            }
        }
    }

    // Pendaftaran class to hold pendaftaran data
    private class Pendaftaran {
        private int id;
        private String nama;
        private double nilai;
        private String progdi_id;
        private Date tanggal_pendaftaran;
        private String status;
        private String nim;

        public Pendaftaran(int id, String nama, double nilai, String progdi_id, Date tanggal_pendaftaran, String status, String nim) {
            this.id = id;
            this.nama = nama;
            this.nilai = nilai;
            this.progdi_id = progdi_id;
            this.tanggal_pendaftaran = tanggal_pendaftaran;
            this.status = status;
            this.nim = nim;
        }

        public int getId() {
            return id;
        }

        public String getNama() {
            return nama;
        }

        public double getNilai() {
            return nilai;
        }

        public String getProgdi_id() {
            return progdi_id;
        }

        public Date getTanggal_pendaftaran() {
            return tanggal_pendaftaran;
        }

        public String getStatus() {
            return status;
        }

        public String getNim() {
            return nim;
        }
    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setSize(new java.awt.Dimension(1500, 1500));

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null}
            },
            new String [] {
                "ID", "Nama", "Nilai", "Program Studi", "Tgl Pendaftaran", "Status", "NIM"
            }
        ));
        jScrollPane1.setViewportView(jTable1);

        jLabel1.setFont(new java.awt.Font("Segoe UI", 1, 24)); // NOI18N
        jLabel1.setText("DATA MAHASISWA BARU KAMPUS XYZ");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(28, 28, 28)
                .addComponent(jScrollPane1)
                .addContainerGap())
            .addGroup(layout.createSequentialGroup()
                .addGap(493, 493, 493)
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 464, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(428, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(42, 42, 42)
                .addComponent(jLabel1)
                .addGap(67, 67, 67)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 453, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(780, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(data_pendaftar.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(data_pendaftar.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(data_pendaftar.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(data_pendaftar.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new data_pendaftar().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    // End of variables declaration//GEN-END:variables
}
