//+------------------------------------------------------------------+
//|                                                  LineGraphic.mqh |
//|                                    Copyright 2024, Mobin Zarekar |
//|                                       https://www.plusonefx.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Mobin Zarekar"
#property link "https://www.plusonefx.net/"
#property version "1.00"

/**================================================================================================
 * *                                           Description
 * This class inhertis from BaseGraphic and is used to create a Line object on the chart.
 * This class dosent directly create the object on the chart. It is used to store the properties
 * to create line object on the chart you should use LineObj class.
 * It Also may use as a parent to other objects graphic classes like  rectangle because they have
 * some common properties.
 *================================================================================================**/

/*=========================================== Include ===========================================*/
#include "BaseGraphic.mqh"

/*=========================================== Class ===========================================*/
class LineGraphic : public BaseGraphic
{
public:
    /*------------------------------------------- Parameters -------------------------------------------*/
    ENUM_LINE_STYLE m_style;
    int m_width;
    bool m_rayRight;
    bool m_rayLeft;
    //* Normal Constructor
    LineGraphic();
    //* Constructor with BaseGraphic
    LineGraphic(BaseGraphic *i_baseGraphic, ENUM_LINE_STYLE i_style = STYLE_SOLID, int i_width = 1, bool i_rayRight = false, bool i_rayLeft = false, bool i_toCreate = true);
    //* Constructor with name, color, width, style and toCreate
    LineGraphic(string i_name, color i_color, int i_width, ENUM_LINE_STYLE i_style = STYLE_SOLID, bool i_toCreate = true);
    //* Constructor with name, color and toCreate
    LineGraphic(string i_name, color i_color, bool i_toCreate = true);
    //* Constructor with name and toCreate
    LineGraphic(string i_name, bool i_toCreate = true);
    //* Constructor with all properties
    LineGraphic(string i_symbol, ENUM_TIMEFRAMES i_timeframe,
                long i_chartId, int i_subWindow,
                int i_hiddenInList, bool i_show,
                bool i_drawAsBackground, bool i_disableSelection,
                string i_name, ENUM_LINE_STYLE i_style,
                color i_color,
                int i_width,
                bool i_rayRight,
                bool i_rayLeft,
                bool i_toCreate = true);

    //* Copy Constructor
    LineGraphic(LineGraphic &i_lineGraphic);

    //* Normal Destructor
    ~LineGraphic(){};

    //* Destroy
    void Destroy()
    {
        BaseGraphic::Destroy();
    }

    /*------------------------------------------- Setters -------------------------------------------*/
    void setStyle(ENUM_LINE_STYLE i_style)
    {
        m_style = i_style;
    };
    void setWidth(int i_width)
    {
        m_width = i_width;
    };
    void setRayRight(bool i_rayRight)
    {
        m_rayRight = i_rayRight;
    };
    void setRayLeft(bool i_rayLeft)
    {
        m_rayLeft = i_rayLeft;
    };

    /*------------------------------------------- Getters -------------------------------------------*/
    ENUM_LINE_STYLE getStyle()
    {
        return m_style;
    };
    int getWidth()
    {
        return m_width;
    };
    bool getRayRight()
    {
        return m_rayRight;
    };
    bool getRayLeft()
    {
        return m_rayLeft;
    };

    /*------------------------------------------- Independent Setters -------------------------------------------*/
    //* Indepentendt Setters are use when you want to change one property of object on the chart but you
    //* dont want to change the property in the class object.
    void setIndipendent_style(ENUM_LINE_STYLE i_style);
    void setIndipendent_width(int i_width);
    void setIndipendent_rayRight(bool i_rayRight);
    void setIndipendent_rayLeft(bool i_rayLeft);

    /*------------------------------------------- Apply -------------------------------------------*/
    void applyStyle();
    void applyWidth();
    void applyRayRight();
    void applyRayLeft();
    virtual void applyAll() override;
};

/**================================================================================================
 * *                                          Normal Constructor
 *   This constructor is used to initialize the object with default values.
 *================================================================================================**/
LineGraphic::LineGraphic()
{
    m_symbol = _Symbol;
    m_timeframe = _Period;
    m_chartId = NULL;
    m_subWindow = 0;
    m_hiddenInList = false;
    m_show = true;
    m_drawAsBackground = false;
    m_disableSelection = false;
    m_name = "Line";
    m_color = clrBlack;
    m_style = STYLE_SOLID;
    m_width = 1;
    m_rayRight = false;
    m_rayLeft = false;
    m_toCreate = true;
};

/**================================================================================================
 * *                                          Constructor with BaseGraphic
 *   This constructor is used to initialize the object with BaseGraphic object.
 *================================================================================================**/
LineGraphic::LineGraphic(BaseGraphic *i_baseGraphic, ENUM_LINE_STYLE i_style = STYLE_SOLID, int i_width = 1, bool i_rayRight = false, bool i_rayLeft = false, bool i_toCreate = true)
{
    m_symbol = i_baseGraphic.m_symbol;
    m_timeframe = i_baseGraphic.m_timeframe;
    m_chartId = i_baseGraphic.m_chartId;
    m_subWindow = i_baseGraphic.m_subWindow;
    m_hiddenInList = i_baseGraphic.m_hiddenInList;
    m_show = i_baseGraphic.m_show;
    m_drawAsBackground = i_baseGraphic.m_drawAsBackground;
    m_disableSelection = i_baseGraphic.m_disableSelection;
    m_name = i_baseGraphic.m_name;
    m_color = i_baseGraphic.m_color;
    m_style = i_style;
    m_width = i_width;
    m_rayRight = i_rayRight;
    m_rayLeft = i_rayLeft;
    m_toCreate = i_toCreate;
};

/**================================================================================================
 * *               Constructor with name, color, width, style and toCreate
 *   This constructor is used to initialize the object with name, color, width, style and toCreate.
 *================================================================================================**/
LineGraphic::LineGraphic(string i_name, color i_color, int i_width, ENUM_LINE_STYLE i_style = STYLE_SOLID, bool i_toCreate = true)
{
    m_symbol = _Symbol;
    m_timeframe = _Period;
    m_chartId = NULL;
    m_subWindow = 0;
    m_hiddenInList = false;
    m_show = true;
    m_drawAsBackground = false;
    m_disableSelection = false;
    m_name = i_name;
    m_color = i_color;
    m_style = i_style;
    m_width = i_width;
    m_rayRight = false;
    m_rayLeft = false;
    m_toCreate = i_toCreate;
};

/**================================================================================================
 * *               Constructor with name, color and toCreate
 *   This constructor is used to initialize the object with name, color and toCreate.
 *================================================================================================**/
LineGraphic::LineGraphic(string i_name, color i_color, bool i_toCreate = true)
{
    m_symbol = _Symbol;
    m_timeframe = _Period;
    m_chartId = NULL;
    m_subWindow = 0;
    m_hiddenInList = false;
    m_show = true;
    m_drawAsBackground = false;
    m_disableSelection = false;
    m_name = i_name;
    m_color = i_color;
    m_style = STYLE_SOLID;
    m_width = 1;
    m_rayRight = false;
    m_rayLeft = false;
    m_toCreate = i_toCreate;
};

/**================================================================================================
 * *               Constructor with name and toCreate
 *   This constructor is used to initialize the object with name and toCreate.
 *================================================================================================**/
LineGraphic::LineGraphic(string i_name, bool i_toCreate = true)
{
    m_symbol = _Symbol;
    m_timeframe = _Period;
    m_chartId = NULL;
    m_subWindow = 0;
    m_hiddenInList = false;
    m_show = true;
    m_drawAsBackground = false;
    m_disableSelection = false;
    m_name = i_name;
    m_color = clrBlack;
    m_style = STYLE_SOLID;
    m_width = 1;
    m_rayRight = false;
    m_rayLeft = false;
    m_toCreate = i_toCreate;
};

/**================================================================================================
 * *               Constructor with all properties
 *   This constructor is used to initialize the object with all properties.
 *================================================================================================**/
LineGraphic::LineGraphic(string i_symbol,
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
                         bool i_toCreate = true)
{
    m_symbol = i_symbol;
    m_name = i_name;
    m_timeframe = i_timeframe;
    m_color = i_color;
    m_chartId = i_chartId;
    m_subWindow = i_subWindow;
    m_hiddenInList = i_hiddenInList;
    m_show = i_show;
    m_style = i_style;
    m_width = i_width;
    m_rayRight = i_rayRight;
    m_rayLeft = i_rayLeft;
    m_drawAsBackground = i_drawAsBackground;
    m_disableSelection = i_disableSelection;
    m_toCreate = i_toCreate;
};

/**================================================================================================
 * *                                          Copy Constructor
 *   This constructor is used to copy the object.
 *================================================================================================**/
LineGraphic::LineGraphic(LineGraphic &i_lineGraphic)
{
    m_symbol = i_lineGraphic.m_symbol;
    m_timeframe = i_lineGraphic.m_timeframe;
    m_chartId = i_lineGraphic.m_chartId;
    m_subWindow = i_lineGraphic.m_subWindow;
    m_hiddenInList = i_lineGraphic.m_hiddenInList;
    m_show = i_lineGraphic.m_show;
    m_drawAsBackground = i_lineGraphic.m_drawAsBackground;
    m_disableSelection = i_lineGraphic.m_disableSelection;
    m_name = i_lineGraphic.m_name;
    m_color = i_lineGraphic.m_color;
    m_style = i_lineGraphic.m_style;
    m_width = i_lineGraphic.m_width;
    m_rayRight = i_lineGraphic.m_rayRight;
    m_rayLeft = i_lineGraphic.m_rayLeft;
    m_toCreate = i_lineGraphic.m_toCreate;
};

/**================================================================================================
 * *                                     setIndipendent_style
 * Set Style On Object on the chart without changing the property of it in the class object.
 *================================================================================================**/
void LineGraphic::setIndipendent_style(ENUM_LINE_STYLE i_style)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_STYLE, i_style);
};

/**================================================================================================
 * *                                    setIndipendent_width
 * Set Width On Object on the chart without changing the property of it in the class object.
 *================================================================================================**/
void LineGraphic::setIndipendent_width(int i_width)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_WIDTH, i_width);
};

/**================================================================================================
 * *                                    setIndipendent_rayRight
 * Set RayRight On Object on the chart without changing the property of it in the class object.
 *================================================================================================**/
void LineGraphic::setIndipendent_rayRight(bool i_rayRight)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_RAY_RIGHT, i_rayRight);
};

/**================================================================================================
 * *                                    setIndipendent_rayLeft
 * Set RayLeft On Object on the chart without changing the property of it in the class object.
 *================================================================================================**/
void LineGraphic::setIndipendent_rayLeft(bool i_rayLeft)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_RAY_LEFT, i_rayLeft);
};

/**=======================================================================================================================
 * *                                               applyStyle
 * Apply Style on the object on the chart using  property of m_style on the class.
 * to use this function tou shpuld set or update the m_style property of the class.
 *=======================================================================================================================**/
void LineGraphic::applyStyle()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_STYLE, m_style);
};

/**=======================================================================================================================
 * *                                             applyWidth
 * Apply Width on the object on the chart using  property of m_width on the class.
 * to use this function tou shpuld set or update the m_width property of the class.
 *=======================================================================================================================**/
void LineGraphic::applyWidth()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_WIDTH, m_width);
};

/**================================================================================================
 * *                                           applyRayRight
 * Apply RayRight on the object on the chart using  property of m_rayRight on the class.
 * to use this function tou shpuld set or update the m_rayRight property of the class.
 *================================================================================================**/
void LineGraphic::applyRayRight()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_RAY_RIGHT, m_rayRight);
};

/**================================================================================================
 * *                                           applyRayLeft
 * Apply RayLeft on the object on the chart using  property of m_rayLeft on the class.
 * to use this function tou shpuld set or update the m_rayLeft property of the class.
 *================================================================================================**/
void LineGraphic::applyRayLeft()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_RAY_LEFT, m_rayLeft);
};

/**================================================================================================
 * *                                           applyAll
 * Apply all the properties of the class on the object on the chart.
 * this function ovverides applyAll function of BaseGraphic class.
 *================================================================================================**/
void LineGraphic::applyAll() override
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
};
