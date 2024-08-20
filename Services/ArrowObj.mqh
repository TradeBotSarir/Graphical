//+------------------------------------------------------------------+
//|                                                     ArrowObj.mqh |
//|                                    Copyright 2024, Mobin Zarekar |
//|                                       https://www.plusonefx.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Mobin Zarekar"
#property link "https://www.plusonefx.net/"
#property version "1.00"

/**================================================================================================
 * *                                           Description
 *================================================================================================**/

/*=========================================== Includes ===========================================*/
#include "../Models/ArrowGraphic.mqh"

/*=========================================== Class ===========================================*/
class ArrowObj : public ArrowGraphic
{
  public:
    /*------------------------------------------- Parametes -------------------------------------------*/
    bool m_isShow;

    /*------------------------------------------- Methos -------------------------------------------*/

    //* Construct with Graphical Data
    ArrowObj(ArrowGraphic *i_data);

    ArrowObj(string i_symbol, ENUM_TIMEFRAMES i_timeframe,
             long i_chartId, int i_subWindow,
             int i_hiddenInList, bool i_show,
             bool i_drawAsBackground, bool i_disableSelection,
             string i_name, bool i_upArrow,
             color i_color,
             int i_width,
             bool i_toCreate = true)
        : ArrowGraphic(i_symbol, i_timeframe,
                       i_chartId, i_subWindow,
                       i_hiddenInList, i_show,
                       i_drawAsBackground, i_disableSelection,
                       i_name, i_upArrow,
                       i_color,
                       i_width,
                       i_toCreate){};

    //* Copy Constructor
    ArrowObj(ArrowObj *i_obj);

    //* Normal Constructor
    ArrowObj();

    //* Normal Destructor
    ~ArrowObj(){};

    //* Destroy the Object
    void Destroy();

    //* Set Basic Graphic Independents
    void setGraphicData(ArrowGraphic *i_data);

    //*  Line Object Proberies
    bool createArrow();
    bool deleteArrow();
    void updatePoint(PivotPoint *i_start);
    void updatePoint();
};

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
ArrowObj::ArrowObj(ArrowGraphic *i_data)
    : ArrowGraphic(i_data)
{
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Copy Constructor
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
ArrowObj::ArrowObj(ArrowObj *i_obj)
{
    m_isCreated = false;
}

/**=======================================================================================================================
 * *                                                     Constructor with PivotPoint
 * this constructor is used when you have a rect object and you want to create a rect object with that rect
 *=======================================================================================================================**/
ArrowObj::ArrowObj()
{
    m_isCreated = false;
}

/**================================================================================================
 * *                                           Destroy
 * this method deletes the rect object and PivotPoints Pointer on it. if you wnat to free memory
 * of all pivot points which are used in this rect object, you have to use this method before
 * delete this object
 *================================================================================================**/
void ArrowObj::Destroy() {
};

/**================================================================================================
 **                                          setGraphicData
 * this method is used to set the graphic properties of the rect object, it will delete the previous
 * graphic properties and set the new one
 *================================================================================================**/
void ArrowObj::setGraphicData(ArrowGraphic *i_data) {

};

/**================================================================================================
 * *                                    updateStart overload 1
 * this method updates start point of rect using tow diffrent overloads
 * 1. updateStart(PivotPoint *i_start) : this method will update the start point of the rect object
 *================================================================================================**/
void ArrowObj::updatePoint(PivotPoint *i_start)
{
    updateObjectPoint(i_start, 0);
};

/**================================================================================================
 * *                                    updateStart overload 2
 * this method updates start point of rect using tow diffrent overloads
 * 2. updateStart() : this method will update the start point of the rect object
 *================================================================================================**/
void ArrowObj::updatePoint()
{
    updateObjectPoint(0);
};

/**================================================================================================
 * *                                           createArrow
 * this method is used to create the rect object on the chart, it will create the object with the
 * properties which are set in the ArrowGraphic object
 *================================================================================================**/
bool ArrowObj::createArrow()
{
    //+--- Object Create //* use parent object to create the object
    createObject(OBJ_ARROW);
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
 * *                                           deleteArrow
 * this method is used to delete the rect object from the chart
 *================================================================================================**/
bool ArrowObj::deleteArrow()
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
