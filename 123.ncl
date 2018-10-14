load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin
    a=addfile("/Users/haibo/Desktop/youting/2003_2012_tau_avg.nc", "r")
    v2=new((/18,180,360/), float)
    v2=a->tau_types
    ;printVarSummary(v2)
     v2 = v2*0.01+225
     v2 = where(v2.lt.0,9999,v2)
     v2@_FillValue = 9999
    ; print(min(v2(5,90:150,70:150)))
    ; print(max(v2(5,90:150,70:150)))
    ; print(v2(5,90:150,70:150))


    wks=gsn_open_wks("eps","test")
    gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
    ;gsn_reverse_colormap(wks)
    res                 = True 
    res@gsnDraw         = False                   
    res@gsnFrame        = False  
    res@gsnSpreadColors = True  

    res@cnLinesOn       =False
    res@cnFillOn        =True
    res@mpLimitMode       = "LatLon"
    res@mpMaxLatF     = 60  
    res@mpMinLatF     = 0
    res@mpMinLonF     = 70
    res@mpMaxLonF     = 150
    res@mpCenterLonF    = 110.
    res@tmXBValues = (/70,80,90,100,110,120,130,140,150/)
    res@tmXBLabels = (/"70E","","90E","","110E","","130E","","150E"/)
    res@tmYLValues = (/0,10,20,30,40,50,60/)
    res@tmYLLabels = (/"0","","20N","","40N","","60N"/)
    res@mpDataBaseVersion                    ="MediumRes"
    res@gsnPaperOrientation                  = "Portrait"
    res@mpOutlineSpecifiers                  = (/"China:states","Taiwan"/)
    res@gsnAddCyclic = False
    res@cnFillMode ="RasterFill"


    res@tiMainString    =""   
    res@gsnRightString = ""
    res@gsnRightStringFontHeightF  = 0.02
    res@gsnLeftString = "" 
    res@gsnLeftStringFontHeightF  = 0.02
    ; res@cnLevelSelectionMode = "AutomaticLevels"  
    res@cnLevelSelectionMode = "ManualLevels"  
    res@cnMinLevelValF=1
    res@cnMaxLevelValF=20
    res@cnLevelSpacingF = 1
      ; res@cnLevelSelectionMode = "ExplicitLevels"
      ; res@cnLevels =  (/2,4,6,8,10,12,14,16,18,20/)
    plot=gsn_csm_contour_map(wks,v2(5,:,:),res)

    draw(plot)
    frame(wks)
 end