//+------------------------------------------------------------------+
//|                                                  RectGraphic.mqh |
//|                                    Copyright 2024, Mobin Zarekar |
//|                                       https://www.plusonefx.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Mobin Zarekar"
#property link "https://www.plusonefx.net/"
#property version "1.00"

/**================================================================================================
 * *                                           Description
 * this class is a child of LineGraphic class and it is used to draw a rectangle on the chart.
 * it inherits of LineGraphic class and has all of its properties and methods.
 *================================================================================================**/

/*=========================================== Inputs ===========================================*/
#include "LineGraphic.mqh"

/*=========================================== Class ===========================================*/
class RectGraphic : public LineGraphic
{
public:
    /*------------------------------------------- Paremeters -------------------------------------------*/
    bool m_isFilled;

    /*------------------------------------------- Methods -------------------------------------------*/
    //* Normal Constructor
    RectGraphic() : LineGraphic(){};
    //* Constructor with baseGraphic
    RectGraphic(BaseGraphic *i_baseGraphic, bool i_isFilled = false, ENUM_LINE_STYLE i_style = STYLE_SOLID, int i_width = 1, bool i_rayRight = false, bool i_rayLeft = false) : LineGraphic(i_baseGraphic, i_style, i_width, i_rayRight, i_rayLeft) { m_isFilled = i_isFilled; };
    //* Constructor with name , color and width
    RectGraphic(string i_name, color i_color, int i_width, bool i_isFilled = false, ENUM_LINE_STYLE i_style = STYLE_SOLID) : LineGraphic(i_name, i_color, i_width, i_style) { m_isFilled = i_isFilled; };
    //* Constructor with name and color
    RectGraphic(string i_name, color i_color, bool i_isFilled = false) : LineGraphic(i_name, i_color) { m_isFilled = i_isFilled; };
    //* Constructor with name and isFilled
    RectGraphic(string i_name, bool i_isFilled = false) : LineGraphic(i_name) { m_isFilled = i_isFilled; };
    //* Constructor with All parameters
    RectGraphic(string i_symbol,
                ENUM_TIMEFRAMES i_timeframe,
                long i_chartId,
                int i_subWindow,
                int i_hiddenInList,
                bool i_show,
                bool i_drawAsBackground,
                bool i_disableSelection,
                string i_name,
                ENUM_LINE_STYLE i_style,
                color i_color,
                int i_width,
                bool i_rayRight,
                bool i_rayLeft,
                bool i_isFilled) : LineGraphic(i_symbol, i_timeframe, i_chartId, i_subWindow, i_hiddenInList, i_show, i_drawAsBackground, i_disableSelection, i_name, i_style, i_color, i_width, i_rayRight, i_rayLeft) { m_isFilled = i_isFilled; };

    //* Copy Constructor
    RectGraphic(const RectGraphic &i_rectGraphic);

    //* Normal Destructor
    ~RectGraphic(){};

    void Destroy()
    {
        LineGraphic::Destroy();
    }

    /*------------------------------------------- Independent Setters -------------------------------------------*/
    //* Indepentendt Setters are use when you want to change one property of object on the chart but you
    //* dont want to change the property in the class object.
    //* apply independent filled
    void applyIndependentFilled(bool i_isFilled);
    /*------------------------------------------- Apply -------------------------------------------*/
    //* Apply filled property
    void applyFiiled();
    //* Apply all properties
    virtual void applyAll() override;
};

/**================================================================================================
 * *                                           Copy Constructor
 * Copy Constructor is used to copy all the properties of the object of the class to the new object.
 *================================================================================================**/
RectGraphic::RectGraphic(const RectGraphic &i_rectGraphic)
{
    m_isFilled = i_rectGraphic.m_isFilled;
};
/**================================================================================================
 * *                                           applyFilled
 * Apply applyFilled on the object on the chart using  property of m_filled on the class.
 * to use this function tou shpuld set or update the m_filled property of the class.
 *================================================================================================**/
void RectGraphic::applyFiiled()
{
    if (m_isFilled)
    {
        ObjectSetInteger(0, m_name, OBJPROP_FILL, m_isFilled);
    }
};

/**================================================================================================
 * *                                           applyIndependentFilled
 * Apply applyFilled on the object on the chart using  property of m_filled on the class.
 * to use this function tou shpuld set or update the m_filled property of the class.
 *================================================================================================**/
void RectGraphic::applyIndependentFilled(bool i_isFilled)
{
    if (i_isFilled)
    {
        ObjectSetInteger(0, m_name, OBJPROP_FILL, i_isFilled);
    }
};

/**================================================================================================
 * *                                           applyAll
 * Apply all properties of the class on the object on the chart.
 *================================================================================================**/
void RectGraphic::applyAll()
{
    //+--- Base
    applyColor();
    applyHiddenInList();
    applyDrawAsBackground();
    applyDisableSelection();
    //+--- Line
    applyStyle();
    applyWidth();
    applyRayRight();
    applyRayLeft();
    //+--- Rect
    applyFiiled();
};
