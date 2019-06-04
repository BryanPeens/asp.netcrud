using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using AForge.Video.DirectShow;
using AForge.Video;
using System.Drawing;

namespace asp.netcrud
{
    public partial class Contact : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(@"Data Source=DESKTOP-FO7MI2G\SQLEXPRESS;Initial Catalog=Euphoria_SampleProject_DB;Integrated Security=True");
        List<string> namelist = new List<string>();

        void PopulateGrid()
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter("ContactViewAll", conn);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                sda.Fill(dt);

                conn.Close();
                gvContact.DataSource = dt;
                gvContact.DataBind();
            }
        }


        void populateDropdownList()
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                SqlCommand cmand = new SqlCommand("ContactViewAll", conn);
                dropdownNames.DataSource = cmand.ExecuteReader();

                dropdownNames.DataBind();
            }
        }

        private FilterInfoCollection webcam;
        private VideoCaptureDevice cam;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btndelete.Enabled = false;
                PopulateGrid();
                populateDropdownList();
            }

        }

        //protected void btndelete_Click(object sender, EventArgs e)
        //{

        //}

        public void clear() {
            hfContactID.Value = "";
            txtname.Text = txtsurname.Text = txtaddress.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnsave.Text = "Save";
            btndelete.Enabled = false;
        }

        protected void btnclear_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                SqlCommand cmand = new SqlCommand("ContactCreateOrUpdate", conn);
                cmand.CommandType = CommandType.StoredProcedure;
                cmand.Parameters.AddWithValue("@ContactID", (hfContactID.Value == "" ? 0 : Convert.ToInt32(hfContactID.Value)));
                cmand.Parameters.AddWithValue("@Name", txtname.Text.Trim());
                cmand.Parameters.AddWithValue("@Surname", txtsurname.Text.Trim());
                cmand.Parameters.AddWithValue("@Address", txtaddress.Text.Trim());
                cmand.ExecuteNonQuery();
                conn.Close();
                clear();

                string contactID = hfContactID.Value;
                if (contactID == "")
                {
                    lblSuccessMessage.Text = "Saved Successfully";
                    PopulateGrid();
                }
                else
                {
                    lblSuccessMessage.Text = "Updated Successfully";
                    PopulateGrid();
                }
            }
        }

        protected void lnView_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter("ContactviewByID", conn);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.AddWithValue("@ContactID", contactID);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                conn.Close();
                hfContactID.Value = contactID.ToString();
                txtname.Text = dt.Rows[0]["Name"].ToString();
                txtsurname.Text = dt.Rows[0]["Surname"].ToString();
                txtaddress.Text = dt.Rows[0]["Address"].ToString();
                btnsave.Text = "Update";
                btndelete.Enabled = true;
            }
        }

        protected void btndelete_Click1(object sender, EventArgs e)
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                SqlCommand cmand = new SqlCommand("ContactDeleteByID", conn);
                cmand.CommandType = CommandType.StoredProcedure;
                cmand.Parameters.AddWithValue("@ContactID", Convert.ToInt32(hfContactID.Value));
                cmand.ExecuteNonQuery();
                conn.Close();
                clear();
                PopulateGrid();
                lblSuccessMessage.Text = "Delete Successful!";
            }
        }

        protected void dropdownNames_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblSelectedName0.Text = dropdownNames.SelectedValue;
            lblSelectedName1.Text = dropdownNames.SelectedIndex.ToString();
            lblSelectedName2.Text = dropdownNames.SelectedItem.Text;

        }
    }
}