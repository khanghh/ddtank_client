package pvePowerBuff
{
   import baglocked.BaglockedManager;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.utils.StaticFormula;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PvePowerBuffMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _otherForeAtk:FilterFrameText;
      
      private var _otherForeDef:FilterFrameText;
      
      private var _otherForeAgl:FilterFrameText;
      
      private var _otherForeLuck:FilterFrameText;
      
      private var _otherForeHp:FilterFrameText;
      
      private var _otherForeMAtk:FilterFrameText;
      
      private var _otherForeMDef:FilterFrameText;
      
      private var _otherForeDmg:FilterFrameText;
      
      private var _otherForeAr:FilterFrameText;
      
      private var _otherRearAtk:FilterFrameText;
      
      private var _otherRearDef:FilterFrameText;
      
      private var _otherRearAgl:FilterFrameText;
      
      private var _otherRearLuck:FilterFrameText;
      
      private var _otherRearHp:FilterFrameText;
      
      private var _otherRearMAtk:FilterFrameText;
      
      private var _otherRearMDef:FilterFrameText;
      
      private var _otherRearDmg:FilterFrameText;
      
      private var _otherRearAr:FilterFrameText;
      
      private var _atkIconBm:Bitmap;
      
      private var _defIconBm:Bitmap;
      
      private var _aglIconBm:Bitmap;
      
      private var _luckIconBm:Bitmap;
      
      private var _hpIconBm:Bitmap;
      
      private var _matkIconBm:Bitmap;
      
      private var _mdefIconBm:Bitmap;
      
      private var _dmgIconBm:Bitmap;
      
      private var _arIconBm:Bitmap;
      
      private var _selfForeAtk:FilterFrameText;
      
      private var _selfForeDef:FilterFrameText;
      
      private var _selfForeAgl:FilterFrameText;
      
      private var _selfForeLuck:FilterFrameText;
      
      private var _selfForeHp:FilterFrameText;
      
      private var _selfForeMAtk:FilterFrameText;
      
      private var _selfForeMDef:FilterFrameText;
      
      private var _selfForeDmg:FilterFrameText;
      
      private var _selfForeAr:FilterFrameText;
      
      private var _selfRearAtk:FilterFrameText;
      
      private var _selfRearDef:FilterFrameText;
      
      private var _selfRearAgl:FilterFrameText;
      
      private var _selfRearLuck:FilterFrameText;
      
      private var _selfRearHp:FilterFrameText;
      
      private var _selfRearMAtk:FilterFrameText;
      
      private var _selfRearMDef:FilterFrameText;
      
      private var _selfRearDmg:FilterFrameText;
      
      private var _selfRearAr:FilterFrameText;
      
      private var _refreshBtn:SimpleBitmapButton;
      
      private var _getBuffBtn:SimpleBitmapButton;
      
      private var _getAgainBtn:SimpleBitmapButton;
      
      private var _btnHelp:BaseButton;
      
      private var _lefttime:FilterFrameText;
      
      private var _huafeiMc:MovieClip;
      
      private var _shuziMc:MovieClip;
      
      private var _others:Vector.<PvePowerBuffPerson>;
      
      private var _selectedPlayer:PvePowerBuffPerson;
      
      private var _arBmArr:Array;
      
      public function PvePowerBuffMainView(){super();}
      
      private function _initView() : void{}
      
      private function _refreshButtonTipsData() : void{}
      
      private function _setOtherPower(param1:PlayerInfo = null) : void{}
      
      private function _setSelfRearTxt(param1:Boolean = false) : void{}
      
      private function _setSelfRearTextVisible(param1:Boolean) : void{}
      
      private function _setTimeText() : void{}
      
      private function _refreshOthers() : void{}
      
      private function _removeOthers() : void{}
      
      private function _initEvent() : void{}
      
      private function __selectPlayerHandler(param1:PvePowerBuffEvent) : void{}
      
      private function __refreshBuffHandler(param1:PvePowerBuffEvent) : void{}
      
      private function __getBuffHandler(param1:PvePowerBuffEvent) : void{}
      
      private function _tweenCompleteHua() : void{}
      
      private function _shuziKuang() : void{}
      
      private function _showArrows(param1:Boolean = false) : void{}
      
      private function __onRefreshResponse(param1:FrameEvent) : void{}
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __getBuffBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __getAgainBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __onGetAgainResponse(param1:FrameEvent) : void{}
      
      private function _removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
