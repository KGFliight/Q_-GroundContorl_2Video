/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl

import QGroundControl.FactControls
import QGroundControl.Controls


SettingsPage {
    property var    _settingsManager:            QGroundControl.settingsManager
    property var    _videoManager:              QGroundControl.videoManager
    property var    _videoSettings:             _settingsManager.videoSettings
    property string _videoSource:               _videoSettings.videoSource.rawValue
    property bool   _isGST:                     _videoManager.gstreamerEnabled
    property bool   _isStreamSource:            _videoManager.isStreamSource
    property bool   _isUDP264:                  _isStreamSource && (_videoSource === _videoSettings.udp264VideoSource)
    property bool   _isUDP265:                  _isStreamSource && (_videoSource === _videoSettings.udp265VideoSource)
    property bool   _isRTSP:                    _isStreamSource && (_videoSource === _videoSettings.rtspVideoSource)
    property bool   _isTCP:                     _isStreamSource && (_videoSource === _videoSettings.tcpVideoSource)
    property bool   _isMPEGTS:                  _isStreamSource && (_videoSource === _videoSettings.mpegtsVideoSource)
    property bool   _videoAutoStreamConfig:     _videoManager.autoStreamConfigured
    property bool   _videoSourceDisabled:       _videoSource === _videoSettings.disabledVideoSource
    property real   _urlFieldWidth:             ScreenTools.defaultFontPixelWidth * 40
    property bool   _requiresUDPUrl:            _isUDP264 || _isUDP265 || _isMPEGTS
    
    // Secondary video source properties
    property string _videoSource2:              _videoSettings.videoSource2.rawValue
    property bool   _isStreamSource2:           _videoManager.isStreamSource
    property bool   _isUDP264_2:                _isStreamSource2 && (_videoSource2 === _videoSettings.udp264VideoSource)
    property bool   _isUDP265_2:                _isStreamSource2 && (_videoSource2 === _videoSettings.udp265VideoSource)
    property bool   _isRTSP_2:                  _isStreamSource2 && (_videoSource2 === _videoSettings.rtspVideoSource)
    property bool   _isTCP_2:                   _isStreamSource2 && (_videoSource2 === _videoSettings.tcpVideoSource)
    property bool   _isMPEGTS_2:                _isStreamSource2 && (_videoSource2 === _videoSettings.mpegtsVideoSource)
    property bool   _videoSource2Disabled:      _videoSource2 === _videoSettings.disabledVideoSource
    property bool   _requiresUDPUrl2:           _isUDP264_2 || _isUDP265_2 || _isMPEGTS_2
    property int    _activeVideoSource:         _videoSettings.activeVideoSource.rawValue

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Primary Video Source")
        headingDescription: _videoAutoStreamConfig ? qsTr("Mavlink camera stream is automatically configured") : ""
        enabled:            !_videoAutoStreamConfig

        LabelledFactComboBox {
            Layout.fillWidth:   true
            label:              qsTr("Source")
            indexModel:         false
            fact:               _videoSettings.videoSource
            visible:            fact.visible
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Secondary Video Source")
        headingDescription: qsTr("Configure a second video source for quick switching")

        LabelledFactComboBox {
            Layout.fillWidth:   true
            label:              qsTr("Source")
            indexModel:         false
            fact:               _videoSettings.videoSource2
            visible:            fact.visible
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Video Source Control")
        headingDescription: qsTr("Triple-click video display to swap between sources")

        LabelledFactComboBox {
            Layout.fillWidth:   true
            label:              qsTr("Active Source")
            indexModel:         false
            fact:               _videoSettings.activeVideoSource
            visible:            fact.visible
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Connection")
        visible:            !_videoSourceDisabled && !_videoAutoStreamConfig && (_isTCP || _isRTSP | _requiresUDPUrl)

        LabelledFactTextField {
            Layout.fillWidth:           true
            textFieldPreferredWidth:    _urlFieldWidth
            label:                      qsTr("RTSP URL")
            fact:                       _videoSettings.rtspUrl
            visible:                    _isRTSP && _videoSettings.rtspUrl.visible
        }

        LabelledFactTextField {
            Layout.fillWidth:           true
            label:                      qsTr("TCP URL")
            textFieldPreferredWidth:    _urlFieldWidth
            fact:                       _videoSettings.tcpUrl
            visible:                    _isTCP && _videoSettings.tcpUrl.visible
        }

        LabelledFactTextField {
            Layout.fillWidth:           true
            textFieldPreferredWidth:    _urlFieldWidth
            label:                      qsTr("UDP URL")
            fact:                       _videoSettings.udpUrl
            visible:                    _requiresUDPUrl && _videoSettings.udpUrl.visible
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Secondary Connection")
        visible:            !_videoSource2Disabled && !_videoAutoStreamConfig && (_isTCP_2 || _isRTSP_2 || _requiresUDPUrl2)

        LabelledFactTextField {
            Layout.fillWidth:           true
            textFieldPreferredWidth:    _urlFieldWidth
            label:                      qsTr("RTSP URL")
            fact:                       _videoSettings.rtspUrl2
            visible:                    _isRTSP_2 && _videoSettings.rtspUrl2.visible
        }

        LabelledFactTextField {
            Layout.fillWidth:           true
            label:                      qsTr("TCP URL")
            textFieldPreferredWidth:    _urlFieldWidth
            fact:                       _videoSettings.tcpUrl2
            visible:                    _isTCP_2 && _videoSettings.tcpUrl2.visible
        }

        LabelledFactTextField {
            Layout.fillWidth:           true
            textFieldPreferredWidth:    _urlFieldWidth
            label:                      qsTr("UDP URL")
            fact:                       _videoSettings.udpUrl2
            visible:                    _requiresUDPUrl2 && _videoSettings.udpUrl2.visible
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Secondary Settings")
        visible:            !_videoSource2Disabled

        LabelledFactComboBox {
            Layout.fillWidth:   true
            label:              qsTr("Secondary Video Fit")
            fact:               _videoSettings.videoFit2
            visible:            _videoSettings.videoFit2.visible
            indexModel:         false
        }

        LabelledFactTextField {
            Layout.fillWidth:   true
            label:              qsTr("Secondary RTSP Timeout (s)")
            fact:               _videoSettings.rtspTimeout2
            visible:            _isRTSP_2 && _videoSettings.rtspTimeout2.visible
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth:   true
        heading:            qsTr("Settings")
        visible:            !_videoSourceDisabled

        LabelledFactTextField {
            Layout.fillWidth:   true
            label:              qsTr("Primary Aspect Ratio")
            fact:               _videoSettings.aspectRatio
            visible:            !_videoAutoStreamConfig && _isStreamSource && _videoSettings.aspectRatio.visible
        }

        LabelledFactTextField {
            Layout.fillWidth:   true
            label:              qsTr("Secondary Aspect Ratio")
            fact:               _videoSettings.aspectRatio2
            visible:            !_videoAutoStreamConfig && _isStreamSource2 && _videoSettings.aspectRatio2.visible
        }

        FactCheckBoxSlider {
            Layout.fillWidth:   true
            text:               qsTr("Stop recording when disarmed")
            fact:               _videoSettings.disableWhenDisarmed
            visible:            !_videoAutoStreamConfig && _isStreamSource && fact.visible
        }

        FactCheckBoxSlider {
            Layout.fillWidth:   true
            text:               qsTr("Low Latency Mode")
            fact:               _videoSettings.lowLatencyMode
            visible:            !_videoAutoStreamConfig && _isStreamSource && fact.visible && _isGST
        }

        LabelledFactComboBox {
            Layout.fillWidth:   true
            label:              qsTr("Video decode priority")
            fact:               _videoSettings.forceVideoDecoder
            visible:            fact.visible
            indexModel:         false
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth: true
        heading:            qsTr("Local Video Storage")

        LabelledFactComboBox {
            Layout.fillWidth:   true
            label:              qsTr("Record File Format")
            fact:               _videoSettings.recordingFormat
            visible:            _videoSettings.recordingFormat.visible
        }

        FactCheckBoxSlider {
            Layout.fillWidth:   true
            text:               qsTr("Auto-Delete Saved Recordings")
            fact:               _videoSettings.enableStorageLimit
            visible:            fact.visible
        }

        LabelledFactTextField {
            Layout.fillWidth:   true
            label:              qsTr("Max Storage Usage")
            fact:               _videoSettings.maxVideoSize
            visible:            fact.visible
            enabled:            _videoSettings.enableStorageLimit.rawValue
        }
    }
}
