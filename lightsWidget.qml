import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    // ── Public properties (fill from your roomModel) ──────
    property string roomName:   "Living room"
    property bool   lightOn:    true
    property real   brightness: 0.65   // 0.0 → 1.0

    signal lightsToggled(bool on)
    signal brightnessChanged(real value)

    // ── Card style ────────────────────────────────────────
    width: 280; height: 180
    radius: 20
    color: "white"
    border.color: "#E0E0E0"
    border.width: 1.5

    // ── Top row: name + toggle ────────────────────────────
    Text {
        id: nameLabel
        text: root.roomName
        font.pixelSize: 20
        font.bold: true
        color: "#1A1A1A"
        anchors { top: parent.top; left: parent.left; margins: 18 }
    }

    // Toggle switch
    Rectangle {
        id: toggleTrack
        width: 44; height: 26
        radius: 13
        color: root.lightOn ? "#4CD964" : "#CCCCCC"
        anchors { top: parent.top; right: parent.right; margins: 18 }

        Behavior on color { ColorAnimation { duration: 200 } }

        Rectangle {
            id: toggleThumb
            width: 22; height: 22
            radius: 11
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            x: root.lightOn ? 20 : 2

            Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }

            layer.enabled: true
            layer.effect: null  // add DropShadow here if you import Qt.GraphicalEffects
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.lightOn = !root.lightOn
                root.lightsToggled(root.lightOn)
            }
        }
    }

    // ── Gauge arc (Canvas) ────────────────────────────────
    Canvas {
        id: gauge
        width: 200; height: 120
        anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 10 }

        // Redraws whenever these change
        onPaint: drawGauge()

        Connections {
            target: root
            function onBrightnessChanged() { gauge.requestPaint() }
            function onLightOnChanged()    { gauge.requestPaint() }
        }

        function drawGauge() {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var cx = width / 2
            var cy = height           // arc center below canvas bottom
            var R  = 90
            var startAngle = Math.PI * 0.75   // bottom-left
            var endAngle   = Math.PI * 2.25   // bottom-right (full sweep = 270°)
            var filled = startAngle + (endAngle - startAngle) * root.brightness

            // Gray background arc
            ctx.beginPath()
            ctx.arc(cx, cy, R, startAngle, endAngle)
            ctx.strokeStyle = "#DDDDDD"
            ctx.lineWidth = 10
            ctx.lineCap = "round"
            ctx.stroke()

            // Yellow filled arc (only when light is on)
            if (root.lightOn && root.brightness > 0.01) {
                ctx.beginPath()
                ctx.arc(cx, cy, R, startAngle, filled)
                ctx.strokeStyle = "#F5A800"
                ctx.lineWidth = 10
                ctx.lineCap = "round"
                ctx.stroke()
            }

            // Knob circle at arc tip
            var kx = cx + R * Math.cos(filled)
            var ky = cy + R * Math.sin(filled)
            ctx.beginPath()
            ctx.arc(kx, ky, 7, 0, Math.PI * 2)
            ctx.fillStyle = "white"
            ctx.fill()
            ctx.strokeStyle = root.lightOn && root.brightness > 0.01 ? "#F5A800" : "#AAAAAA"
            ctx.lineWidth = 2.5
            ctx.stroke()
        }

        // ── Drag to set brightness ────────────────────────
        MouseArea {
            anchors.fill: parent
            onPositionChanged: function(mouse) { updateBrightness(mouse.x, mouse.y) }
            onPressed:         function(mouse) { updateBrightness(mouse.x, mouse.y) }
        }

        function updateBrightness(mx, my) {
            var cx = width / 2
            var cy = height
            var startAngle = Math.PI * 0.75
            var endAngle   = Math.PI * 2.25
            var angle = Math.atan2(my - cy, mx - cx)
            // Wrap negative angles into the correct range
            if (angle < startAngle - Math.PI) angle += Math.PI * 2
            var v = (angle - startAngle) / (endAngle - startAngle)
            root.brightness = Math.max(0.0, Math.min(1.0, v))
            root.brightnessChanged(root.brightness)
        }
    }

    // ── Light bulb icon ───────────────────────────────────
    Text {
        text: "💡"
        font.pixelSize: 36
        anchors { bottom: parent.bottom; bottomMargin: 18; horizontalCenter: parent.horizontalCenter }

        // Glow effect when on (requires Qt.GraphicalEffects)
        opacity: root.lightOn ? 1.0 : 0.4
        Behavior on opacity { NumberAnimation { duration: 300 } }
    }
}

