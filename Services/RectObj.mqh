//+------------------------------------------------------------------+
//|                                                      RectObj.mqh |
//|                                    Copyright 2024, Mobin Zarekar |
//|                                       https://www.plusonefx.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Mobin Zarekar"
#property link "https://www.plusonefx.net/"
#property version "1.00"

/**================================================================================================
 * *                                           Description
 * This class uses to create and manage rect Object On the chart, it uses RectGraphic class to
 * store the graphic properties and PivotPoint class to store the coordinates of the rect.
 *================================================================================================**/

/*=========================================== Includes ===========================================*/
#include "../../Leg/Leg.mqh"
#include "../Models/RectGraphic.mqh"

/*=========================================== Class ===========================================*/
class RectObj : public RectGraphic
{
  public:
    /*------------------------------------------- Parametes -------------------------------------------*/
    bool m_isShow;

    /*------------------------------------------- Methos -------------------------------------------*/
    //* Construct with PivotPoint
    RectObj(RectGraphic *i_data);
    RectObj(PivotPoint *i_start, PivotPoint *i_end, string i_name = "NOTSET");
    RectObj(PivotPoint *i_start, PivotPoint *i_end, RectGraphic *i_data);
    RectObj(PivotPoint *i_start, PivotPoint *i_end, RectGraphic *i_data, string i_name);
    //* Copy Constructor
    RectObj(RectObj *i_obj);

    //*     Construct with Leg
    //! Imagine when you have a leg object and you want to create a rect object with that leg
    RectObj(Leg *i_legCoordinate, string i_name = "NOTSET", bool i_useLegPointer = false);
    RectObj(Leg *i_legCoordinate, RectGraphic *i_data, bool i_useLegPointer = false);
    RectObj(Leg *i_legCoordinate, RectGraphic *i_data, string i_name, bool i_useLegPointer = false);

    //* Normal Constructor
    RectObj();

    //* Normal Destructor
    ~RectObj();

    //* Destroy the Object
    void Destroy();

    //*Set Basic Graphic Independents
    void setGraphicData(RectGraphic *i_data);

    //*  Line Object Proberies
    bool createRect();
    bool deleteRect();
    void updateStart(PivotPoint *i_start);
    void updateStart();
    void updateEnd(PivotPoint *i_end);
    void updateEnd();
};

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
RectObj::RectObj(RectGraphic *i_data)
    : RectGraphic(i_data)
{
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Copy Constructor
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
RectObj::RectObj(RectObj *i_obj)
{
    m_isCreated = false;
}
/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
RectObj::RectObj(PivotPoint *i_start, PivotPoint *i_end, string i_name = "NOTSET")
{
    m_points.Add(i_start);
    m_points.Add(i_end);
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
RectObj::RectObj(PivotPoint *i_start, PivotPoint *i_end, RectGraphic *i_data)
    : RectGraphic(i_data)
{
    m_points.Clear();
    m_points.Add(i_start);
    m_points.Add(i_end);
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
RectObj::RectObj(PivotPoint *i_start, PivotPoint *i_end, RectGraphic *i_data, string i_name)
    : RectGraphic(i_data)
{
    m_name = i_name;
    m_points.Clear();
    m_points.Add(i_start);
    m_points.Add(i_end);
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
RectObj::RectObj()
{
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with Leg
 * this constructor is used when you have a leg object and you want to create a rect object with that leg
 * ! if useLegPointer is true, the rect object will use the leg object pointer to get the coordinates
 * ! if useLegPointer is false, the rect objecct will create its own PivotPoints from the leg object
 *=======================================================================================================================**/
RectObj::RectObj(Leg *i_legCoordinate, string i_name = "NOTSET", bool i_useLegPointer = false)
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
 * this constructor is used when you have a leg object and you want to create a rect object with that leg
 * ! if useLegPointer is true, the rect object will use the leg object pointer to get the coordinates
 * ! if useLegPointer is false, the rect objecct will create its own PivotPoints from the leg object
 *=======================================================================================================================**/
RectObj::RectObj(Leg *i_legCoordinate, RectGraphic *i_data, bool i_useLegPointer = false)
    : RectGraphic(i_data)
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
 * this constructor is used when you have a leg object and you want to create a rect object with that leg
 * ! if useLegPointer is true, the rect object will use the leg object pointer to get the coordinates
 * ! if useLegPointer is false, the rect objecct will create its own PivotPoints from the leg object
 *=======================================================================================================================**/
RectObj::RectObj(Leg *i_legCoordinate, RectGraphic *i_data, string i_name, bool i_useLegPointer = false)
    : RectGraphic(i_data)
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
 * Using this normal destructor you can delete the rect objectGraphic but PivotPoints will not
 *  be deleted, to delete PivotPoints you have to use Destroy()
 *================================================================================================**/
RectObj::~RectObj()
{
    RectGraphic::Destroy();
};

/**================================================================================================
 * *                                           Destroy
 * this method deletes the rect object and PivotPoints Pointer on it. if you wnat to free memory
 * of all pivot points which are used in this rect object, you have to use this method before
 * delete this object
 *================================================================================================**/
void RectObj::Destroy() {
};

/**================================================================================================
 **                                          CsetGraphicData
 * this method is used to set the graphic properties of the rect object, it will delete the previous
 * graphic properties and set the new one
 *================================================================================================**/
void RectObj::setGraphicData(RectGraphic *i_data) {

};

/**================================================================================================
 * *                                    updateStart overload 1
 * this method updates start point of rect using tow diffrent overloads
 * 1. updateStart(PivotPoint *i_start) : this method will update the start point of the rect object
 *================================================================================================**/
void RectObj::updateStart(PivotPoint *i_start)
{
    updateObjectPoint(i_start, 0);
};

/**================================================================================================
 * *                                    updateStart overload 2
 * this method updates start point of rect using tow diffrent overloads
 * 2. updateStart() : this method will update the start point of the rect object
 *================================================================================================**/
void RectObj::updateStart()
{
    updateObjectPoint(0);
};

/**================================================================================================
 * *                                    updateEnd overload 1
 * this method updates end point of rect using tow diffrent overloads
 * 1. updateEnd(PivotPoint *i_end) : this method will update the end point of the rect object
 *================================================================================================**/
void RectObj::updateEnd(PivotPoint *i_end)
{
    updateObjectPoint(i_end, 1);
};

/**================================================================================================
 * *                                    updateEnd overload 2
 * this method updates end point of rect using tow diffrent overloads
 * 2. updateEnd() : this method will update the end point of the rect object
 *================================================================================================**/
void RectObj::updateEnd()
{
    updateObjectPoint(1);
};

/**================================================================================================
 * *                                           createRect
 * this method is used to create the rect object on the chart, it will create the object with the
 * properties which are set in the RectGraphic object
 *================================================================================================**/
bool RectObj::createRect()
{
    //+--- Object Create //* use parent object to create the object
    createObject(OBJ_RECTANGLE);
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
 * *                                           deleteRect
 * this method is used to delete the rect object from the chart
 *================================================================================================**/
bool RectObj::deleteRect()
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
