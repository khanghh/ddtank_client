/**
 * Created by hoanghongkhang on 6/24/17.
 */
package game.view.matchGameAuto
{
import com.pickgliss.ui.UICreatShortcut;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.utils.ObjectUtils;

import ddt.manager.ChatManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import gameCommon.GameControl;
import gameCommon.HeroAutoControl;
import gameAuto.autoControl.MatchGameAutoControl;

public class MatchGameAutoView extends Sprite implements Disposeable
{


    private var _heroAutoMovie:MovieClip;

    private var _heroAutoState:Boolean;

    public var _autoControl:MatchGameAutoControl;

    public function MatchGameAutoView()
    {
        _autoControl = new MatchGameAutoControl();
        super();
        init();
        initEvent();
        //disableOperation();
    }

    private function init() : void
    {
        _heroAutoMovie = UICreatShortcut.creatAndAdd("game.view.HeroAutoMC",this);
        _heroAutoMovie.visible = false;
        _heroAutoState = false;
    }

    public function updateWind(param1:int) : void
    {
        if(_autoControl)
        {
            _autoControl.updateWind(param1);
        }
    }

    private function disableOperation() : void
    {
        GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = false;
    }

    private function initEvent() : void
    {
        GameControl.Instance.Current.selfGamePlayer.addEventListener("die",__die);
    }

    private function removeEvent() : void
    {
        GameControl.Instance.Current.selfGamePlayer.removeEventListener("die",__die);
    }

    protected function __die(param1:Event) : void
    {
        visible = false;
        setAutoState(false);
        dispose();
    }

    public function setAutoState(param1:Boolean) : void
    {
        if(_heroAutoState != param1)
        {
            _heroAutoState = param1;
            update();
            if(_autoControl)
            {
                _autoControl.setAutoState(autoState);
            }
        }
    }

    public function get autoState() : Boolean
    {
        return _heroAutoState;
    }

    private function update() : void
    {
        if(_heroAutoMovie)
        {
            _heroAutoMovie.visible = _heroAutoState;
        }
    }

    public function dispose() : void
    {
        removeEvent();
        ObjectUtils.disposeObject(_heroAutoMovie);
        _heroAutoMovie = null;
        if(_autoControl)
        {
            _autoControl.clear();
        }
        _autoControl = null;
        if(parent)
        {
            parent.removeChild(this);
        }
    }
}
}
