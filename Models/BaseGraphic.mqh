//+------------------------------------------------------------------+
//|                                                  BaseGraphic.mqh |
//|                                    Copyright 2024, Mobin Zarekar |
//|                                       https://www.plusonefx.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Mobin Zarekar"
#property link "https://www.plusonefx.net/"
#property version "1.00"

/**================================================================================================
 * *                                           Description
 *  This class contains all parameters and methods which are common between all graphic objects
 *  Other graphic objects like TrendLine and Rectangle inherit from this class
 *================================================================================================**/

/*=========================================== Includes ===========================================*/
#include "../../Global/Models/PivotPoint.mqh"
#include <Arrays/ArrayObj.mqh>

/*=========================================== class ===========================================*/
class BaseGraphic
{
private:
    /*------------------------------------------- Parameters -------------------------------------------*/

    /*------------------------------------------- Methods -------------------------------------------*/
    void createSinglePointObject(ENUM_OBJECT i_objType);
    void createDoublePointObject(ENUM_OBJECT i_objType);

public:
    /*------------------------------------------- Parameters -------------------------------------------*/
    CArrayObj *m_points;
    string m_symbol;
    string m_name;
    ENUM_TIMEFRAMES m_timeframe;
    color m_color;
    long m_chartId;
    int m_subWindow;
    int m_hiddenInList;
    bool m_show;
    bool m_drawAsBackground;
    bool m_disableSelection;
    bool m_toCreate;
    bool m_isCreated;
    bool m_selected;

    /*------------------------------------------- Methods -------------------------------------------*/
    //*  Constructor
    BaseGraphic();

    //* Destructor
    ~BaseGraphic();

    //*  Add Point
    void addPoint(PivotPoint *i_pivotPoint)
    {
        m_points.Add(i_pivotPoint);
    }

    void addPoint(int i_index, double i_value, datetime i_time)
    {
        PivotPoint *pivotPoint = new PivotPoint(i_index, i_value, i_time);
        m_points.Add(pivotPoint);
    }

    //*   Objects create
    void createObject(ENUM_OBJECT i_objType);

    //*  Object handlers
    void hideObject();
    void showObject();
    void updateObjectPoint(PivotPoint *i_pivotPoint, int i_anchor);
    void updateObjectPoint(int i_anchor);
    void updateAllObjectPoint();
    void deleteObject()
    {
        ObjectDelete(m_chartId, m_name);
    } // Just delete the object on chart
    void Destroy();       // Delete the object on chart and remove all points from m_points
    void destroyPoints(); // delete all points in m_points by pointers
    /*------------------------------------------- Setters -------------------------------------------*/
    void setSymbol(string i_symbol)
    {
        m_symbol = i_symbol;
    }
    void setName(string i_name)
    {
        m_name = i_name;
    }
    void setTimeframe(ENUM_TIMEFRAMES i_timeframe)
    {
        m_timeframe = i_timeframe;
    }
    void setColor(color i_color)
    {
        m_color = i_color;
    }
    void setChartId(long i_chartId)
    {
        m_chartId = i_chartId;
    }
    void setSubWindow(int i_subWindow)
    {
        m_subWindow = i_subWindow;
    }
    void setHiddenInList(int i_hiddenInList)
    {
        m_hiddenInList = i_hiddenInList;
    }
    void setShow(bool i_show)
    {
        m_show = i_show;
    }
    void setDrawAsBackground(bool i_drawAsBackground)
    {
        m_drawAsBackground = i_drawAsBackground;
    }
    void setDisableSelection(bool i_disableSelection)
    {
        m_disableSelection = i_disableSelection;
    }

    /*------------------------------------------- Getters -------------------------------------------*/
    string getSymbol()
    {
        return m_symbol;
    }
    string getName()
    {
        return m_name;
    }
    ENUM_TIMEFRAMES getTimeframe()
    {
        return m_timeframe;
    }
    color getColor()
    {
        return m_color;
    }
    long getChartId()
    {
        return m_chartId;
    }
    int getSubWindow()
    {
        return m_subWindow;
    }
    int getHiddenInList()
    {
        return m_hiddenInList;
    }
    bool getShow()
    {
        return m_show;
    }
    bool getDrawAsBackground()
    {
        return m_drawAsBackground;
    }
    bool getDisableSelection()
    {
        return m_disableSelection;
    }

    /*------------------------------------------- Independent Setters and apples -------------------------------------------*/
    void setIndipendent_color(color i_color);
    void setIndipendent_hiddenInList(bool i_hiddenInList);
    void setIndependent_drawAsBackground(bool i_drawAsBackground);
    void setIndependent_disableSelection(bool i_disableSelection);

    /*------------------------------------------- apply Functions -------------------------------------------*/
    void applyColor();
    void applyHiddenInList();
    void applyDrawAsBackground();
    void applyDisableSelection();
    //* Virtual function to apply all parameters will be ovverriden in child classes
    virtual void applyAll();
};

/**================================================================================================
 * *                                      Normal   Constructor
 *================================================================================================**/
BaseGraphic::BaseGraphic()
{
    m_points = new CArrayObj();
    m_points.FreeMode(false); // PivotPoint objects are not deleted when m_points is cleared
}

/**================================================================================================
 * *                                  Normal Destructor
 * destractor just delete m_points array and the PivotPoint objects are not deleted and still exist
 * if you want to delete the PivotPoint objects you should call Destroy()
 *================================================================================================**/
BaseGraphic::~BaseGraphic()
{
    delete m_points;
}

/**================================================================================================
 * *                                           Desstroy
 * Delete and remove all pointers in the object
 *================================================================================================**/
void BaseGraphic::Destroy()
{
    deleteObject();
    destroyPoints();
    // delete m_points;
};

/**================================================================================================
 * *                                           destroyPoints
 * Delete all pointers in the object
 *================================================================================================**/
void BaseGraphic::destroyPoints()
{
    for (int i = 0; i < m_points.Total(); i++)
    {
        PivotPoint *pivotPoint = m_points.At(i);
        if (CheckPointer(pivotPoint) != POINTER_DYNAMIC)
        {
            continue;
        }
        delete pivotPoint;
    }
    m_points.Clear();
}

/**================================================================================================
 * *                                           setIndipendent_color
 *   Set Colot in graphic object whitout applying it in m_color
 *  Uses when you want to apply a color to graphic object without changing graphic object of it
 *================================================================================================**/
void BaseGraphic::setIndipendent_color(color i_color)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_COLOR, i_color);
};

/**================================================================================================
 * *                                           setIndipendent_hiddenInList
 *  Set hiddenInList in graphic object whitout applying it in m_hiddenInList
 * Uses when you want to apply a hiddenInList to graphic object without changing graphic object of it
 *================================================================================================**/
void BaseGraphic::setIndipendent_hiddenInList(bool i_hiddenInList)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_HIDDEN, i_hiddenInList);
};

/**================================================================================================
 * *                                           setIndependent_drawAsBackground
 * Set drawAsBackground in graphic object whitout applying it in m_drawAsBackground
 *================================================================================================**/
void BaseGraphic::setIndependent_drawAsBackground(bool i_drawAsBackground)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_BACK, i_drawAsBackground);
};

/**================================================================================================
 * *                                           setIndependent_disableSelection
 * Set disableSelection in graphic object whitout applying it in m_disableSelection
 *================================================================================================**/
void BaseGraphic::setIndependent_disableSelection(bool i_disableSelection)
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_SELECTABLE, i_disableSelection);
};

/**================================================================================================
 * *                                           applyColor
 * Apply m_color to graphic object
 *================================================================================================**/
void BaseGraphic::applyColor()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_COLOR, m_color);
};

/**================================================================================================
 * *                                           applyHiddenInList
 * Apply m_hiddenInList to graphic object
 *================================================================================================**/
void BaseGraphic::applyHiddenInList()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_HIDDEN, m_hiddenInList);
};

/**================================================================================================
 * *                                           applyDrawAsBackground
 * Apply m_drawAsBackground to graphic object
 *================================================================================================**/
void BaseGraphic::applyDrawAsBackground()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_BACK, m_drawAsBackground);
};

/**================================================================================================
 * *                                           applyDisableSelection
 * Apply m_disableSelection to graphic object
 *================================================================================================**/
void BaseGraphic::applyDisableSelection()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_SELECTABLE, m_disableSelection);
};

/**================================================================================================
 * *                                           applyAll
 * Apply all parameters to graphic object
 *================================================================================================**/
void BaseGraphic::applyAll()
{
    applyColor();
    applyHiddenInList();
    applyDrawAsBackground();
    applyDisableSelection();
};

/**================================================================================================
 * *                                           createObject
 * Create object on chart
 *================================================================================================**/
void BaseGraphic::createObject(ENUM_OBJECT i_objType)
{
    if (m_toCreate == false)
    {
        return;
    }
    switch (i_objType)
    {
    case OBJ_TREND:
    {
        createDoublePointObject(i_objType);
        break;
    }
    case OBJ_RECTANGLE:
    {
        createDoublePointObject(i_objType);
        break;
    }
    case OBJ_ARROW:
    {
        createSinglePointObject(i_objType);
        break;
    }

    default:
        break;
    };
}

/**================================================================================================
 * *                           Private :     createSinglePointObject
 * Create Object on chart which Needs only one point
 *================================================================================================**/
void BaseGraphic::createSinglePointObject(ENUM_OBJECT i_objType)
{
    PivotPoint *start = m_points.At(0);
    ObjectCreate(m_chartId, m_name, i_objType, m_subWindow, start.time, start.value);
};

/**================================================================================================
 * *                           Private :     createDoublePointObject
 * Create Object on chart which Needs two points
 *================================================================================================**/
void BaseGraphic::createDoublePointObject(ENUM_OBJECT i_objType)
{

    PivotPoint *startss = m_points.At(0);
    PivotPoint *endss = m_points.At(1);
    if (CheckPointer(startss) == POINTER_INVALID || CheckPointer(endss) == POINTER_INVALID)
    {
        DebugBreak();
    }
    ObjectCreate(m_chartId, m_name, i_objType, m_subWindow, startss.time, startss.value, endss.time, endss.value);
};

/**================================================================================================
 * *                                           showObject
 * show object on chart
 *================================================================================================**/
void BaseGraphic::showObject()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
};

/**================================================================================================
 * *                                           hideObject
 * hide object on chart
 *================================================================================================**/
void BaseGraphic::hideObject()
{
    ObjectSetInteger(m_chartId, m_name, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
};

/**================================================================================================
 * *                                           updateObjectPoint
 * Update a point in object
 * First Mode gets a PivotPoint and an anchor and update the anchor point with the PivotPoint
 * it updates the m_points array with the new PivotPoint
 *================================================================================================**/
void BaseGraphic::updateObjectPoint(PivotPoint *i_pivotPoint, int i_anchor)
{
    if (i_pivotPoint == NULL)
    {
        Print("Error: Pivot Point is NULL");
        DebugBreak();
    }

    if (m_points.Total() < i_anchor)
    {
        Print("Error: Anchor is out of range");
        DebugBreak();
    }
    m_points.Update(i_anchor, i_pivotPoint);
    ObjectSetInteger(m_chartId, m_name, OBJPROP_TIME, i_anchor, i_pivotPoint.time);
    ObjectSetDouble(m_chartId, m_name, OBJPROP_PRICE, i_anchor, i_pivotPoint.value);
};

/**================================================================================================
 * *                                           updateObjectPoint
 * Update a point in object
 * Second Mode gets an anchor and update the Object on chart using information of points on m_points
 * so you should update the m_points array before calling this function
 *================================================================================================**/
void BaseGraphic::updateObjectPoint(int i_anchor)
{
    if (m_points.Total() < i_anchor)
    {
        Print("Error: Anchor is out of range");
        DebugBreak();
    }
    PivotPoint *pivotPoint = m_points.At(i_anchor);
    m_points.Update(i_anchor, pivotPoint);
    ObjectSetInteger(m_chartId, m_name, OBJPROP_TIME, i_anchor, pivotPoint.time);
    ObjectSetDouble(m_chartId, m_name, OBJPROP_PRICE, i_anchor, pivotPoint.value);
};

/**================================================================================================
 * *                                           updateAllObjectPoint
 * Update all points in object on chart
 * consider you have updated multiple points in m_points array and you want to update all of them
 * on the graphic object on chart, you can call this function
 *================================================================================================**/
void BaseGraphic::updateAllObjectPoint()
{
    for (int i = 0; i < m_points.Total(); i++)
    {
        PivotPoint *pivotPoint = m_points.At(i);
        m_points.Update(i, pivotPoint);
        ObjectSetInteger(m_chartId, m_name, OBJPROP_TIME, i, pivotPoint.time);
        ObjectSetDouble(m_chartId, m_name, OBJPROP_PRICE, i, pivotPoint.value);
    }
};