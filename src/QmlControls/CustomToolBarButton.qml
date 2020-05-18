/****************************************************************************
 *
 * (c) 2009-2019 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 * @file
 *   @author Gus Grubba <gus@auterion.com>
 */

import QtQuick                      2.11
import QtQuick.Controls             2.4
import QtGraphicalEffects           1.14

import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0

Rectangle {
    id:                             drawerMenu
    height: _contents.height
    property bool highlighted: false
    property bool containsSubItem: false
    property string text
    property url isrc


    Rectangle {
        id:                         _backg
        anchors.centerIn:           parent
        anchors.left:               parent.left
        anchors.right:               parent.right
        height:                     parent.height * 0.6
        width:                      parent.width * 0.95
        visible:                    highlighted
        radius:                     20
    }
    DropShadow {
        source: _backg
        color: "#d6d4d4"//qgcPal.buttonText
        anchors.fill: _backg
        radius: 5
        transparentBorder: true
        visible:  _backg.visible
        verticalOffset: 2
        spread:  0.5
    }


    Row {
        id: _contents
        spacing:                    ScreenTools.defaultFontPixelWidth
        anchors.left:               drawerMenu.left
        anchors.leftMargin:         ScreenTools.defaultFontPixelWidth
        anchors.verticalCenter:     drawerMenu.verticalCenter
        Item {
            height:                 ScreenTools.defaultFontPixelHeight * 3
            width:                  1
        }
        QGCColoredImage {
            id:                     _icon
            height:                 ScreenTools.defaultFontPixelHeight
            width:                  height
            sourceSize.height:      parent.height
            fillMode:               Image.PreserveAspectFit
            color:                  "#858585"//qgcPal.buttonText
            source:                 drawerMenu.isrc
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle {
            height:                     ScreenTools.defaultFontPixelHeight
            width:                      ScreenTools.defaultFontPixelHeight * 7
            anchors.verticalCenter: parent.verticalCenter
            Label {
                id:                     _label
                visible:                text !== ""
                text:                   drawerMenu.text
                color:                  qgcPal.buttonText
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        QGCColoredImage {
            height:                 ScreenTools.defaultFontPixelHeight * 0.5
            width:                  height
            sourceSize.height:      parent.height
            fillMode:               Image.PreserveAspectFit
            color:                  qgcPal.buttonText
            source:                 "/qmlimages/MenuDown"
            anchors.verticalCenter: parent.verticalCenter
            visible:                containsSubItem
            rotation:               highlighted ? 0 : -90
        }
    }

    signal clicked()
    // Process hover events
    MouseArea {
        id:                         mouseArea
        anchors.fill:               parent
        onClicked:                  {highlighted = containsSubItem ? !highlighted : true;  drawerMenu.clicked()}
    }
}
