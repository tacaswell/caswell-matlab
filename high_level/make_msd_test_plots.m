function make_msd_test_plots(msd_data,fig)
   
    figure(fig)

    plot(msd_data.v1.msd./msd_data.v1.msd_count,'--x')
    plot(msd_data.v2.msd./msd_data.v2.msd_count,'-o')
    plot(msd_data.v3.msd./msd_data.v3.msd_count,'-.s')
    
    title(msd_data.stack_name)

    
    
end