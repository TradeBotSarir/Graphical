class CCreateObjects
{
private:
    //+------------------------------------------------------------------+
    //| Check the values of rectangle's anchor points and set default    |
    //| values for empty ones                                            |
    //+------------------------------------------------------------------+
    void ChangeRectangleEmptyPoints(datetime &time1, double &price1,
                                    datetime &time2, double &price2)
    {
        //--- if the first point's time is not set, it will be on the current bar
        if (!time1)
            time1 = TimeCurrent();
        //--- if the first point's price is not set, it will have Bid value
        if (!price1)
            price1 = SymbolInfoDouble(Symbol(), SYMBOL_BID);
        //--- if the second point's time is not set, it is located 9 bars left from the second one
        if (!time2)
        {
            //--- array for receiving the open time of the last 10 bars
            datetime temp[10];
            CopyTime(Symbol(), Period(), time1, 10, temp);
            //--- set the second point 9 bars left from the first one
            time2 = temp[0];
        }
        //--- if the second point's price is not set, move it 300 points lower than the first one
        if (!price2)
            price2 = price1 - 300 * SymbolInfoDouble(Symbol(), SYMBOL_POINT);
    }

    bool EditCreate(const long chart_ID = 0,                           // chart's ID
                    const string name = "Edit",                        // object name
                    const int sub_window = 0,                          // subwindow index
                    const int x = 0,                                   // X coordinate
                    const int y = 0,                                   // Y coordinate
                    const int width = 50,                              // width
                    const int height = 18,                             // height
                    const string text = "Text",                        // text
                    const string font = "Arial",                       // font
                    const int font_size = 10,                          // font size
                    const ENUM_ALIGN_MODE align = ALIGN_CENTER,        // alignment type
                    const bool read_only = false,                      // ability to edit
                    const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                    const color clr = clrBlack,                        // text color
                    const color back_clr = clrWhite,                   // background color
                    const color border_clr = clrNONE,                  // border color
                    const bool back = false,                           // in the background
                    const bool selection = false,                      // highlight to move
                    const bool hidden = true,                          // hidden in the object list
                    const long z_order = 0)                            // priority for mouse click
    {
        //--- reset the error value
        ResetLastError();
        //--- create edit field
        if (!ObjectCreate(chart_ID, name, OBJ_EDIT, sub_window, 0, 0))
        {
            Print(__FUNCTION__,
                  ": failed to create \"Edit\" object! Error code = ", GetLastError());
            return (false);
        }
        //--- set object coordinates
        ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
        ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
        //--- set object size
        ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
        ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
        //--- set the text
        ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
        //--- set text font
        ObjectSetString(chart_ID, name, OBJPROP_FONT, font);
        //--- set font size
        ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);
        //--- set the type of text alignment in the object
        ObjectSetInteger(chart_ID, name, OBJPROP_ALIGN, align);
        //--- enable (true) or cancel (false) read-only mode
        ObjectSetInteger(chart_ID, name, OBJPROP_READONLY, read_only);
        //--- set the chart's corner, relative to which object coordinates are defined
        ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
        //--- set text color
        ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
        //--- set background color
        ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
        //--- set border color
        ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);
        //--- display in the foreground (false) or background (true)
        ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
        //--- enable (true) or disable (false) the mode of moving the label by mouse
        ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
        ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
        //--- hide (true) or display (false) graphical object name in the object list
        ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
        //--- set the priority for receiving the event of a mouse click in the chart
        ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
        //--- successful execution
        return (true);
    }

    //+------------------------------------------------------------------+
    //| Create rectangle label                                           |
    //+------------------------------------------------------------------+
    bool RectLabelCreate(const long chart_ID = 0,                           // chart's ID
                         const string name = "RectLabel",                   // label name
                         const int sub_window = 0,                          // subwindow index
                         const int x = 0,                                   // X coordinate
                         const int y = 0,                                   // Y coordinate
                         const int width = 50,                              // width
                         const int height = 18,                             // height
                         const color back_clr = clrDarkBlue,                // background color
                         const ENUM_BORDER_TYPE border = BORDER_SUNKEN,     // border type
                         const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                         const color clr = clrRed,                          // flat border color (Flat)
                         const ENUM_LINE_STYLE style = STYLE_SOLID,         // flat border style
                         const int line_width = 1,                          // flat border width
                         const bool back = false,                           // in the background
                         const bool selection = false,                      // highlight to move
                         const bool hidden = true,                          // hidden in the object list
                         const long z_order = 0)                            // priority for mouse click
    {
        //--- reset the error value
        ResetLastError();
        //--- create a rectangle label
        if (!ObjectCreate(chart_ID, name, OBJ_RECTANGLE_LABEL, sub_window, 0, 0))
        {
            Print(__FUNCTION__,
                  ": failed to create a rectangle label! Error code = ", GetLastError());
            return (false);
        }
        //--- set label coordinates
        ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
        ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
        //--- set label size
        ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
        ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
        //--- set background color
        ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
        //--- set border type
        ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_TYPE, border);
        //--- set the chart's corner, relative to which point coordinates are defined
        ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
        //--- set flat border color (in Flat mode)
        ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
        //--- set flat border line style
        ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);
        //--- set flat border width
        ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, line_width);
        //--- display in the foreground (false) or background (true)
        ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
        //--- enable (true) or disable (false) the mode of moving the label by mouse
        ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
        ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
        //--- hide (true) or display (false) graphical object name in the object list
        ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
        //--- set the priority for receiving the event of a mouse click in the chart
        ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
        //--- successful execution
        return (true);
    }

    // Function to add seconds to a MqlDateTime structure
    void AddSecondsToMqlDateTime(MqlDateTime &dt, int seconds)
    {
        // Convert MqlDateTime to datetime (seconds since 1970.01.01)
        datetime t = StructToTime(dt);
        // Add seconds
        t += seconds;
        // Convert back to MqlDateTime
        TimeToStruct(t, dt);
    }

public:
    // Function to calculate the datetime of a future bar, skipping weekends
    datetime GetTimeForFutureBar(int I_rT, int futureBarIndex)
    {
        MqlDateTime dt;
        TimeToStruct(TimeCurrent(), dt); // Convert current time to MqlDateTime

        for (int i = I_rT - 1; i < futureBarIndex; ++i)
        {
            AddSecondsToMqlDateTime(dt, PeriodSeconds(PERIOD_CURRENT)); // Add minutes for each bar

            // Check if the new time falls on a weekend
            while (dt.day_of_week == 6 || dt.day_of_week == 0)
            {
                // If Saturday, add enough minutes to reach Monday
                if (dt.day_of_week == 6)
                {
                    AddSecondsToMqlDateTime(dt, 2 * 24 * 60 * 60); // Add 2 days worth of minutes
                }
                else
                { // If Sunday, add one day's worth of minutes
                    AddSecondsToMqlDateTime(dt, 24 * 60 * 60);
                }
            }
        }

        // Convert the final MqlDateTime back to datetime
        return StructToTime(dt);
    }

    //+---- Create Future Objects
    void CreateFutureVLine(int I_rates_total, int FutureBar, color I_Clr,
                           ENUM_LINE_STYLE I_Style, int I_LineWith,
                           string I_pref_1, string I_name)
    {

        datetime futureBarTime = GetTimeForFutureBar(I_rates_total, FutureBar); // Get the datetime for the future bar
        // Draw the vertical line on the chart
        ObjectCreate(0, I_pref_1 + I_name, OBJ_VLINE, 0, futureBarTime, 0);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_COLOR, I_Clr);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_WIDTH, I_LineWith);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_STYLE, I_Style);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_SELECTED, false);
        ChartRedraw();
    }

    void PlaceArrow(int FutureBar, int I_TrendType, double i_value, const datetime &i_time[], string I_pref, int i_arrowWith = 1)
    {
        // Calculate the price level for arrow placement
        double arrowPrice = 0;
        // Set arrow properties based on signal type
        int arrowCode = 0;
        color arrowColor = clrBlack;
        ENUM_ARROW_ANCHOR arrow_anchor = ANCHOR_TOP;
        if (I_TrendType == 1)
        {
            arrowCode = 233; // Up arrow code
            arrowColor = Lime;
            arrow_anchor = ANCHOR_TOP;
        }
        else if (I_TrendType == -1)
        {
            arrowCode = 234; // Down arrow code
            arrowColor = Red;
            arrow_anchor = ANCHOR_BOTTOM;
        }
        arrowPrice = i_value;

        // Draw the arrow on the chart
        ObjectCreate(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJ_ARROW, 0, i_time[FutureBar], arrowPrice);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ANCHOR, arrow_anchor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ARROWCODE, arrowCode);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_COLOR, arrowColor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_WIDTH, i_arrowWith);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
    }

    void PlaceArrow(int FutureBar, int I_TrendType, double i_value, const datetime i_signalTime, string I_pref, int i_arrowWith = 2, color i_buyColor = clrGreen, color i_sellColor = clrRed)
    {
        // Calculate the price level for arrow placement
        double arrowPrice = 0;
        // Set arrow properties based on signal type
        int arrowCode = 0;
        color arrowColor = clrBlack;
        ENUM_ARROW_ANCHOR arrow_anchor = ANCHOR_TOP;
        if (I_TrendType == 1)
        {
            arrowCode = 233; // Up arrow code
            arrowColor = i_buyColor;
            arrow_anchor = ANCHOR_TOP;
        }
        else if (I_TrendType == -1)
        {
            arrowCode = 234; // Down arrow code
            arrowColor = i_sellColor;
            arrow_anchor = ANCHOR_BOTTOM;
        }
        arrowPrice = i_value;

        // Draw the arrow on the chart
        ObjectCreate(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJ_ARROW, 0, i_signalTime, arrowPrice);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ANCHOR, arrow_anchor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ARROWCODE, arrowCode);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_COLOR, arrowColor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_WIDTH, i_arrowWith);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
    }

    void PlaceArrow(int FutureBar, int I_TrendType, const double &I_High[], const double &I_Low[], const datetime &i_time[], string I_pref, int i_arrowWith = 2)
    {
        // Calculate the price level for arrow placement
        double arrowPrice = 0;
        // Set arrow properties based on signal type
        int arrowCode = 0;
        color arrowColor = clrBlack;
        ENUM_ARROW_ANCHOR arrow_anchor = ANCHOR_TOP;
        if (I_TrendType == 1)
        {
            arrowCode = 233; // Up arrow code
            arrowColor = Lime;
            arrowPrice = I_Low[FutureBar];
            arrow_anchor = ANCHOR_TOP;
        }
        else if (I_TrendType == -1)
        {
            arrowCode = 234; // Down arrow code
            arrowColor = Red;
            arrowPrice = I_High[FutureBar];
            arrow_anchor = ANCHOR_BOTTOM;
        }
        // Draw the arrow on the chart
        ObjectCreate(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJ_ARROW, 0, i_time[FutureBar], arrowPrice);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ANCHOR, arrow_anchor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ARROWCODE, arrowCode);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_COLOR, arrowColor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_WIDTH, i_arrowWith);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
    }

    void PlaceArrow(int FutureBar, int rates_total, int I_TrendType, string I_pref, int i_arrowWith = 2)
    {
        // Calculate the price level for arrow placement
        double arrowPrice = 0;
        // Set arrow properties based on signal type
        int arrowCode = 0;
        color arrowColor = clrBlack;
        ENUM_ARROW_ANCHOR arrow_anchor = ANCHOR_TOP;
        if (I_TrendType == 1)
        {
            arrowCode = 233; // Up arrow code
            arrowColor = Lime;
            arrowPrice = iLow(_Symbol, PERIOD_CURRENT, rates_total - FutureBar - 1);
            arrow_anchor = ANCHOR_TOP;
        }
        else if (I_TrendType == -1)
        {
            arrowCode = 234; // Down arrow code
            arrowColor = Red;
            arrowPrice = iHigh(_Symbol, PERIOD_CURRENT, rates_total - FutureBar - 1);
            arrow_anchor = ANCHOR_BOTTOM;
        }

        // Draw the arrow on the chart
        ObjectCreate(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJ_ARROW, 0, iTime(_Symbol, PERIOD_CURRENT, rates_total - FutureBar - 1), arrowPrice);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ANCHOR, arrow_anchor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_ARROWCODE, arrowCode);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_COLOR, arrowColor);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_WIDTH, i_arrowWith);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
        ObjectSetInteger(0, I_pref + "BT_Arrow_" + IntegerToString(FutureBar), OBJPROP_SELECTED, false);
    }

    void CreateVLine(datetime I_barTime, color I_Clr,
                     ENUM_LINE_STYLE I_Style, int I_LineWith,
                     string I_pref_1, string I_name)
    {

        // Draw the vertical line on the chart
        ObjectCreate(0, I_pref_1 + I_name, OBJ_VLINE, 0, I_barTime, 0);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_COLOR, I_Clr);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_WIDTH, I_LineWith);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_STYLE, I_Style);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, I_pref_1 + I_name, OBJPROP_SELECTED, false);
        ChartRedraw();
    }

    void CreateLoadingNote(int loadingPercent)
    {
        int Ichart_height = int(ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0));
        int Ichart_width = int(ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0));
        int x = Ichart_width / 2 - 200;
        int y = Ichart_height / 2 - 100;
        int BigBoxWidth = 400;
        int BigBoxHeight = 200;
        int percentHeight = 30;
        int percentWidth = int(BigBoxWidth / 100);
        int x_percentbar = x;
        int y_percentbar = y + 210;
        if (ObjectFind(NULL, "LoadingNote") < 0)
        {
            for (int i = 0; i <= 100; i++)
            {
                RectLabelCreate(NULL,                 // chart's ID
                                "Perc" + string(i),   // label name
                                0,                    // subwindow index
                                x + percentWidth * i, // X coordinate
                                y_percentbar,         // Y coordinate
                                percentWidth,         // width
                                percentHeight,        // height
                                clrWhite,             // background color
                                BORDER_SUNKEN,        // border type
                                CORNER_LEFT_UPPER,    // chart corner for anchoring
                                clrWhite,             // flat border color (Flat)
                                STYLE_SOLID,          // flat border style
                                0,                    // flat border width
                                false,                // in the background
                                false,                // highlight to move
                                true,                 // hidden in the object list
                                0);
            }
            ChartRedraw();
        }
        EditCreate(NULL, "LoadingNote", 0,
                   x, y,
                   400, 200, "Loading " + IntegerToString(loadingPercent) + "%",
                   "Arial", 24, ALIGN_CENTER, true, CORNER_LEFT_UPPER, clrDarkBlue, clrWhite, clrNONE, false, false, true, 0);

        //--- set background color

        ObjectSetInteger(NULL, "Perc" + string(loadingPercent), OBJPROP_BGCOLOR, clrDarkBlue);
        ChartRedraw();
    }

    void RemoveLoadingNote()
    {
        ObjectDelete(0, "LoadingNote");
        for (int i = 0; i <= 100; i++)
        {
            ObjectDelete(0, "Perc" + string(i));
        }
        ChartRedraw();
    }

    //+------------------------------------------------------------------+
    //| Create rectangle by the given coordinates                        |
    //+------------------------------------------------------------------+
    bool PlaceRectangle(const long chart_ID = 0,                   // chart's ID
                        const string name = "Rectangle",           // rectangle name
                        const int sub_window = 0,                  // subwindow index
                        datetime time1 = 0,                        // first point time
                        double price1 = 0,                         // first point price
                        datetime time2 = 0,                        // second point time
                        double price2 = 0,                         // second point price
                        const color clr = clrRed,                  // rectangle color
                        const ENUM_LINE_STYLE style = STYLE_SOLID, // style of rectangle lines
                        const int width = 1,                       // width of rectangle lines
                        const bool fill = false,                   // filling rectangle with color
                        const bool back = false,                   // in the background
                        const bool selection = true,               // highlight to move
                        const bool hidden = true,                  // hidden in the object list
                        const long z_order = 0)                    // priority for mouse click
    {
        //--- set anchor points' coordinates if they are not set
        ChangeRectangleEmptyPoints(time1, price1, time2, price2);
        //--- reset the error value
        ResetLastError();
        //--- create a rectangle by the given coordinates
        if (!ObjectCreate(chart_ID, name, OBJ_RECTANGLE, sub_window, time1, price1, time2, price2))
        {
            Print(__FUNCTION__,
                  ": failed to create a rectangle! Error code = ", GetLastError());
            return (false);
        }
        //--- set rectangle color
        ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
        //--- set the style of rectangle lines
        ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);
        //--- set width of the rectangle lines
        ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, width);
        //--- enable (true) or disable (false) the mode of filling the rectangle
        ObjectSetInteger(chart_ID, name, OBJPROP_FILL, fill);
        //--- display in the foreground (false) or background (true)
        ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
        //--- enable (true) or disable (false) the mode of highlighting the rectangle for moving
        //--- when creating a graphical object using ObjectCreate function, the object cannot be
        //--- highlighted and moved by default. Inside this method, selection parameter
        //--- is true by default making it possible to highlight and move the object
        ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
        ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
        //--- hide (true) or display (false) graphical object name in the object list
        ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
        //--- set the priority for receiving the event of a mouse click in the chart
        ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
        //--- successful execution
        return (true);
    }

    //+------------------------------------------------------------------+
    //| Create SLTP                                                       |
    //+------------------------------------------------------------------+
    void PlaceSLTP(int FutureBar,
                   int rates_total,
                   bool isTP,
                   int SLTP_Number,
                   double I_Val,
                   string I_pref = "pref",
                   long ChartID = 0)
    {
        // Calculate the price level for arrow placement
        double arrowPrice = I_Val;
        color arrowColor = Red;
        string type = "SL";
        if (isTP)
        {
            arrowColor = Lime;
            type = "TP";
        }
        string Name = I_pref + type + IntegerToString(SLTP_Number) + "_" + IntegerToString(FutureBar);
        ObjectCreate(ChartID, Name, OBJ_ARROWED_LINE, 0, iTime(_Symbol, PERIOD_CURRENT, rates_total - FutureBar + 4),
                     I_Val, iTime(_Symbol, PERIOD_CURRENT, rates_total - FutureBar + 1), I_Val);
        ObjectSetInteger(ChartID, Name, OBJPROP_COLOR, arrowColor);
        ObjectSetInteger(ChartID, Name, OBJPROP_WIDTH, 1);
        ObjectSetInteger(ChartID, Name, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(ChartID, Name, OBJPROP_SELECTED, false);
        ChartRedraw();
    };

    void PlaceSLTP(int FutureBar,
                   datetime i_barTime,
                   bool isTP,
                   int SLTP_Number,
                   double I_Val,
                   string I_pref = "pref",
                   long ChartID = 0,
                   int i_width = 1)
    {
        // Calculate the price level for arrow placement
        double arrowPrice = I_Val;
        color arrowColor = Red;
        string type = "SL";
        if (isTP)
        {
            arrowColor = Lime;
            type = "TP";
        }
        long startTimeReduce = PeriodSeconds(_Period) * 4;
        string Name = I_pref + type + IntegerToString(SLTP_Number) + "_" + IntegerToString(FutureBar);
        ObjectCreate(ChartID, Name, OBJ_ARROWED_LINE, 0, i_barTime - startTimeReduce,
                     I_Val, i_barTime, I_Val);
        ObjectSetInteger(ChartID, Name, OBJPROP_COLOR, arrowColor);
        ObjectSetInteger(ChartID, Name, OBJPROP_WIDTH, i_width);
        ObjectSetInteger(ChartID, Name, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(ChartID, Name, OBJPROP_SELECTED, false);
        ChartRedraw();
    };
};
