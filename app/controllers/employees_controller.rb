class EmployeesController < ApplicationController
  before_action :set_employee, except: %i[index show_admin]
  before_action :authenticate_employee!, except: %i[ index ]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
  end


  def show; end


  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy
  end

  def show_admin
    if Election.admin_elect_exists?
      @employee = Election.current_admin
      @previous_terms = Election.previous_terms(@employee)
    else
      flash[:info] = 'there currently is no admin, this means they have either been vetoed or an election is ongoing'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = current_employee || Employee.find(params[:id])  
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :role, :contributions, :email, :occupation) if params[:employee]
    end
end
