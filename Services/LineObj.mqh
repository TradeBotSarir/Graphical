//+------------------------------------------------------------------+
//|                                                      LineObj.mqh |
//|                                    Copyright 2024, Mobin Zarekar |
//|                                       https://www.plusonefx.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Mobin Zarekar"
#property link "https://www.plusonefx.net/"
#property version "1.00"

/**================================================================================================
 * *                                           Description
 * This class uses to create and manage line Object On the chart, it uses LineGraphic class to
 * store the graphic properties and PivotPoint class to store the coordinates of the line.
 *================================================================================================**/

/*=========================================== Includes ===========================================*/
#include "../../Leg/Leg.mqh"
#include "../Models/LineGraphic.mqh"

/*=========================================== Class ===========================================*/
class LineObj : public LineGraphic
{
public:
    /*------------------------------------------- Parametes -------------------------------------------*/
    bool m_isShow;

    /*------------------------------------------- Methos -------------------------------------------*/
    //* Construct with PivotPoint
    LineObj(LineGraphic *i_data);
    LineObj(PivotPoint *i_start, PivotPoint *i_end, string i_name = "NOTSET");
    LineObj(PivotPoint *i_start, PivotPoint *i_end, LineGraphic *i_data);
    LineObj(PivotPoint *i_start, PivotPoint *i_end, LineGraphic *i_data, string i_name);
    //* Create Vertical Line
    LineObj(double i_price, string i_name = "NOTSET");

    //*     Construct with Leg
    //! Imagine when you have a leg object and you want to create a line object with that leg
    LineObj(Leg *i_legCoordinate, string i_name = "NOTSET", bool i_useLegPointer = false);
    LineObj(Leg *i_legCoordinate, LineGraphic *i_data, bool i_useLegPointer = false);
    LineObj(Leg *i_legCoordinate, LineGraphic *i_data, string i_name, bool i_useLegPointer = false);

    //* Normal Constructor
    LineObj();

    //* Normal Destructor
    ~LineObj();

    //* Destroy the Object
    void Destroy();

    //*Set Basic Graphic Independents
    void setGraphicData(LineGraphic *i_data);

    //*  Line Object Proberies
    bool createLine();
    bool deleteLine();
    void updateStart(PivotPoint *i_start);
    void updateStart();
    void updateEnd(PivotPoint *i_end);
    void updateEnd();
    void setLinePointsByLeg(Leg *i_legCoordinate, bool i_useLegPointer = true)
    {
        if (i_useLegPointer)
        {
            destroyPoints();
            m_points.Add(i_legCoordinate.startPoint);
            m_points.Add(i_legCoordinate.endPoint);
        }
        else
        {
            destroyPoints();
            m_points.Add(new PivotPoint(i_legCoordinate.startPoint));
            m_points.Add(new PivotPoint(i_legCoordinate.endPoint));
        }
    }
};

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a line object and you want to create a line object with that line
 *=======================================================================================================================**/
LineObj::LineObj(LineGraphic *i_data)
    : LineGraphic(i_data)
{
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a line object and you want to create a line object with that line
 *=======================================================================================================================**/
LineObj::LineObj(PivotPoint *i_start, PivotPoint *i_end, string i_name = "NOTSET")
{
    m_points.Clear();
    m_points.Add(i_start);
    m_points.Add(i_end);
    m_name = i_name;
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a line object and you want to create a line object with that line
 *=======================================================================================================================**/
LineObj::LineObj(PivotPoint *i_start, PivotPoint *i_end, LineGraphic *i_data)
    : LineGraphic(i_data)
{
    m_points.Clear();
    m_points.Add(i_start);
    m_points.Add(i_end);
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a line object and you want to create a line object with that line
 *=======================================================================================================================**/
LineObj::LineObj(PivotPoint *i_start, PivotPoint *i_end, LineGraphic *i_data, string i_name)
    : LineGraphic(i_data)
{

    m_name = i_name;
    m_points.Clear();
    m_points.Add(i_start);
    m_points.Add(i_end);
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a line object and you want to create a line object with that line
 *=======================================================================================================================**/
LineObj::LineObj()
{
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Create Vertical Line
 * this constructor is used when you want to create a vertical line on the chart
 *=======================================================================================================================**/
LineObj::LineObj(double i_price, string i_name = "NOTSET")
{
    m_points.Add(new PivotPoint(0, i_price));
    m_points.Add(new PivotPoint(1, i_price));
    m_name = i_name;
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with Leg
 * this constructor is used when you have a leg object and you want to create a line object with that leg
 * ! if useLegPointer is true, the line object will use the leg object pointer to get the coordinates
 * ! if useLegPointer is false, the line objecct will create its own PivotPoints from the leg object
 *=======================================================================================================================**/
LineObj::LineObj(Leg *i_legCoordinate, string i_name = "NOTSET", bool i_useLegPointer = false)
{
    if (i_useLegPointer)
    {
        m_points.Add(i_legCoordinate.startPoint);
        m_points.Add(i_legCoordinate.endPoint);
    }
    else
    {
        m_points.Add(new PivotPoint(i_legCoordinate.startPoint));
        m_points.Add(new PivotPoint(i_legCoordinate.endPoint));
    }
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with Leg
 * this constructor is used when you have a leg object and you want to create a line object with that leg
 * ! if useLegPointer is true, the line object will use the leg object pointer to get the coordinates
 * ! if useLegPointer is false, the line objecct will create its own PivotPoints from the leg object
 *=======================================================================================================================**/
LineObj::LineObj(Leg *i_legCoordinate, LineGraphic *i_data, bool i_useLegPointer = false)
    : LineGraphic(i_data)
{
    if (i_useLegPointer)
    {
        destroyPoints();
        m_points.Add(i_legCoordinate.startPoint);
        m_points.Add(i_legCoordinate.endPoint);
    }
    else
    {
        destroyPoints();
        m_points.Add(new PivotPoint(i_legCoordinate.startPoint));
        m_points.Add(new PivotPoint(i_legCoordinate.endPoint));
    }
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with Leg
 * this constructor is used when you have a leg object and you want to create a line object with that leg
 * ! if useLegPointer is true, the line object will use the leg object pointer to get the coordinates
 * ! if useLegPointer is false, the line objecct will create its own PivotPoints from the leg object
 *=======================================================================================================================**/
LineObj::LineObj(Leg *i_legCoordinate, LineGraphic *i_data, string i_name, bool i_useLegPointer = false)
    : LineGraphic(i_data)
{
    if (i_useLegPointer)
    {
        m_name = i_name;
        destroyPoints();
        m_points.Add(i_legCoordinate.startPoint);
        m_points.Add(i_legCoordinate.endPoint);
    }
    else
    {
        m_name = i_name;
        destroyPoints();
        m_points.Add(new PivotPoint(i_legCoordinate.startPoint));
        m_points.Add(new PivotPoint(i_legCoordinate.endPoint));
    }
    m_isCreated = false;
}

/**================================================================================================
 * *                                      Normal Destructor
 * Using this normal destructor you can delete the line objectGraphic but PivotPoints will not
 *  be deleted, to delete PivotPoints you have to use Destroy()
 *================================================================================================**/
LineObj::~LineObj() {

};

/**================================================================================================
 * *                                           Destroy
 * this method deletes the line object and PivotPoints Pointer on it. if you wnat to free memory
 * of all pivot points which are used in this line object, you have to use this method before
 * delete this object
 *================================================================================================**/
void LineObj::Destroy() {
};

/**================================================================================================
 **                                          CsetGraphicData
 * this method is used to set the graphic properties of the line object, it will delete the previous
 * graphic properties and set the new one
 *================================================================================================**/
void LineObj::setGraphicData(LineGraphic *i_data)
{
    m_symbol = i_data.m_symbol;
    m_width = i_data.m_width;
    m_color = i_data.m_color;
    m_style = i_data.m_style;
    m_chartId = i_data.m_chartId;
    m_subWindow = i_data.m_subWindow;
    m_name = i_data.m_name;
    m_show = i_data.m_show;
    m_drawAsBackground = i_data.m_drawAsBackground;
    m_disableSelection = i_data.m_disableSelection;
    m_toCreate = i_data.m_toCreate;
    m_selected = i_data.m_selected;
    m_rayLeft = i_data.m_rayLeft;
    m_rayRight = i_data.m_rayRight;
};

/**================================================================================================
 * *                                    updateStart overload 1
 * this method updates start point of line using tow diffrent overloads
 * 1. updateStart(PivotPoint *i_start) : this method will update the start point of the line object
 *================================================================================================**/
void LineObj::updateStart(PivotPoint *i_start)
{
    updateObjectPoint(i_start, 0);
};

/**================================================================================================
 * *                                    updateStart overload 2
 * this method updates start point of line using tow diffrent overloads
 * 2. updateStart() : this method will update the start point of the line object
 *================================================================================================**/
void LineObj::updateStart()
{
    updateObjectPoint(0);
};

/**================================================================================================
 * *                                    updateEnd overload 1
 * this method updates end point of line using tow diffrent overloads
 * 1. updateEnd(PivotPoint *i_end) : this method will update the end point of the line object
 *================================================================================================**/
void LineObj::updateEnd(PivotPoint *i_end)
{
    updateObjectPoint(i_end, 1);
};

/**================================================================================================
 * *                                    updateEnd overload 2
 * this method updates end point of line using tow diffrent overloads
 * 2. updateEnd() : this method will update the end point of the line object
 *================================================================================================**/
void LineObj::updateEnd()
{
    updateObjectPoint(1);
};

/**================================================================================================
 * *                                           createLine
 * this method is used to create the line object on the chart, it will create the object with the
 * properties which are set in the LineGraphic object
 *================================================================================================**/
bool LineObj::createLine()
{
    //+--- Object Create //* use parent object to create the object
    createObject(OBJ_TREND);
    m_isCreated = true;
    //+--- Set Graphic Properties
    applyAll();
    //+--- hide if needed
    if (!m_show)
    {
        hideObject();
        m_isShow = false;
    }
    ChartRedraw();
    return true;
};

/**================================================================================================
 * *                                           deleteLine
 * this method is used to delete the line object from the chart
 *================================================================================================**/
bool LineObj::deleteLine()
{
    if (m_isCreated)
    {
        deleteObject();
        m_isCreated = false;
        ChartRedraw();
        return true;
    }
    return false;
};
