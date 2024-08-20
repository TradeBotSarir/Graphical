//+------------------------------------------------------------------+
//|                                                  ArrowGraphic.mqh |
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
 * It Also may use as a parent to other objects graphic classes like  rectangle because they have
 * some common properties.
 *================================================================================================**/

/*=========================================== Include ===========================================*/
#include "BaseGraphic.mqh"

/*=========================================== Class ===========================================*/
class ArrowGraphic : public BaseGraphic
{
  public:
    ENUM_ARROW_ANCHOR m_anchor;
    int m_Code;
    int m_width;
    bool m_upArrow;

    /*------------------------------------------- Parameters -------------------------------------------*/

    //* Normal Constructor
    ArrowGraphic();
    //* Constructor with BaseGraphic
    ArrowGraphic(BaseGraphic *i_baseGraphic, bool i_upArrow, int i_width = 1, bool i_toCreate = true);
    //* Constructor with name, color, width, style and toCreate
    ArrowGraphic(string i_name, color i_color, int i_width, bool i_upArrow, bool i_toCreate = true);
    //* Constructor with all properties
    ArrowGraphic(string i_symbol, ENUM_TIMEFRAMES i_timeframe,
                 long i_chartId, int i_subWindow,
                 int i_hiddenInList, bool i_show,
                 bool i_drawAsBackground, bool i_disableSelection,
                 string i_name, bool i_upArrow,
                 color i_color,
                 int i_width,
                 bool i_toCreate = true);

    //* Copy Constructor
    ArrowGraphic(ArrowGraphic &i_arrowGraphic);

    //* Normal Destructor
    ~ArrowGraphic(){};

    /*------------------------------------------- Setters -------------------------------------------*/
    void setIsUpArrow(bool i_isUpArrow)
    {
        m_upArrow = i_isUpArrow;
    };
    void setWidth(int i_width)
    {
        m_width = i_width;
    };

    /*------------------------------------------- Getters -------------------------------------------*/
    /*------------------------------------------- Independent Setters -------------------------------------------*/
    //* Indepentendt Setters are use when you want to change one property of object on the chart but you
    //* dont want to change the property in the class object.
    void setIndipendent_isUp(bool i_isUpArrow)
    {
        ObjectSetInteger(m_chartId, m_name, OBJPROP_ARROWCODE, i_isUpArrow);
    };
    void setIndipendent_width(int i_width)
    {
        ObjectSetInteger(m_chartId, m_name, OBJPROP_WIDTH, i_width);
    };

    /*------------------------------------------- Apply -------------------------------------------*/
    void applyAnchor();
    void applyCode();
    void applyWidth();
    virtual void applyAll() override;
};

/**================================================================================================
 * *                                          Normal Constructor
 *   This constructor is used to initialize the object with default values.
 *================================================================================================**/
ArrowGraphic::ArrowGraphic()
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
    m_width = 1;
    m_toCreate = true;
    m_anchor = ANCHOR_TOP;
    m_Code = 233;
    m_upArrow = true;
};

/**================================================================================================
 * *                                          Constructor with BaseGraphic
 *   This constructor is used to initialize the object with BaseGraphic object.
 *================================================================================================**/
ArrowGraphic::ArrowGraphic(BaseGraphic *i_baseGraphic, bool i_upArrow, int i_width = 1, bool i_toCreate = true)
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
    m_width = i_width;
    m_toCreate = i_toCreate;
    if (i_upArrow)
    {
        m_anchor = ANCHOR_TOP;
        m_Code = 233;
    }
    else
    {
        m_anchor = ANCHOR_BOTTOM;
        m_Code = 234;
    }
};

/**================================================================================================
 * *               Constructor with name, color, width, style and toCreate
 *   This constructor is used to initialize the object with name, color, width, style and toCreate.
 *================================================================================================**/
ArrowGraphic::ArrowGraphic(string i_name, color i_color, int i_width, bool i_upArrow, bool i_toCreate = true)
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
    m_width = i_width;
    m_toCreate = i_toCreate;
    m_upArrow = i_upArrow;
    m_Code = i_upArrow ? 233 : 234;
    m_anchor = i_upArrow ? ANCHOR_TOP : ANCHOR_BOTTOM;
};

/**================================================================================================
 * *               Constructor with all properties
 *   This constructor is used to initialize the object with all properties.
 *================================================================================================**/
ArrowGraphic::ArrowGraphic(string i_symbol, ENUM_TIMEFRAMES i_timeframe,
                           long i_chartId, int i_subWindow,
                           int i_hiddenInList, bool i_show,
                           bool i_drawAsBackground, bool i_disableSelection,
                           string i_name, bool i_upArrow,
                           color i_color,
                           int i_width,
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
    m_width = i_width;
    m_drawAsBackground = i_drawAsBackground;
    m_disableSelection = i_disableSelection;
    m_toCreate = i_toCreate;
    m_upArrow = i_upArrow;
    m_Code = i_upArrow ? 233 : 234;
    m_anchor = i_upArrow ? ANCHOR_TOP : ANCHOR_BOTTOM;
};

/**================================================================================================
 * *                                          Copy Constructor
 *   This constructor is used to copy the object.
 *================================================================================================**/
ArrowGraphic::ArrowGraphic(ArrowGraphic &i_arrowGraphic)
{
    m_symbol = i_arrowGraphic.m_symbol;
    m_timeframe = i_arrowGraphic.m_timeframe;
    m_chartId = i_arrowGraphic.m_chartId;
    m_subWindow = i_arrowGraphic.m_subWindow;
    m_hiddenInList = i_arrowGraphic.m_hiddenInList;
    m_show = i_arrowGraphic.m_show;
    m_drawAsBackground = i_arrowGraphic.m_drawAsBackground;
    m_disableSelection = i_arrowGraphic.m_disableSelection;
    m_name = i_arrowGraphic.m_name;
    m_color = i_arrowGraphic.m_color;
    m_width = i_arrowGraphic.m_width;
    m_toCreate = i_arrowGraphic.m_toCreate;
    m_anchor = i_arrowGraphic.m_anchor;
    m_Code = i_arrowGraphic.m_Code;
    m_upArrow = i_arrowGraphic.m_upArrow;
};

/**=======================================================================================================================
 * *                                             applyWidth
 * Apply Width on the object on the chart using  property of m_width on the class.
 * to use this function tou shpuld set or update the m_width property of the class.
 *=======================================================================================================================**/
void ArrowGraphic::applyWidth()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_WIDTH, m_width);
};

/**=======================================================================================================================
 * *                                             applyIsUpArrow
 * Apply IsUpArrow on the object on the chart using  property of m_upArrow on the class.
 * to use this function tou shpuld set or update the m_upArrow property of the class.
 *=======================================================================================================================**/
void ArrowGraphic::applyAnchor()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_ANCHOR, m_anchor);
};

/**=======================================================================================================================
 * *                                             applyCode
 * Apply Code on the object on the chart using  property of m_Code on the class.
 * to use this function tou shpuld set or update the m_Code property of the class.
 *=======================================================================================================================**/
void ArrowGraphic::applyCode()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_ARROWCODE, m_Code);
};

/**================================================================================================
 * *                                           applyAll
 * Apply all the properties of the class on the object on the chart.
 * this function ovverides applyAll function of BaseGraphic class.
 *================================================================================================**/
void ArrowGraphic::applyAll() override
{
    //+--- Base
    applyColor();
    applyHiddenInList();
    applyDrawAsBackground();
    applyDisableSelection();
    applyAnchor();
    //+--- Line
    applyWidth();

    applyCode();
};
