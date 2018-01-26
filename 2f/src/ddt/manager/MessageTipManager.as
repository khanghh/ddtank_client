package ddt.manager
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import morn.core.events.UIEvent;
   
   public class MessageTipManager
   {
      
      private static var instance:MessageTipManager;
       
      
      private var _messageTip:Sprite;
      
      private var _tipString:String;
      
      private var _tipText:FilterFrameText;
      
      private var _tipBg:DisplayObject;
      
      private var _isPlaying:Boolean;
      
      private var _currentType:int;
      
      private var _emptyGridContent:EmptyGridMsgHolder;
      
      private var _tipContainer:Sprite;
      
      private var _duration:Number;
      
      public function MessageTipManager(){super();}
      
      public static function getInstance() : MessageTipManager{return null;}
      
      private function __onShowMornUIMessage(param1:UIEvent) : void{}
      
      public function get currentType() : int{return 0;}
      
      public function get isPlaying() : Boolean{return false;}
      
      private function setContent(param1:String) : DisplayObject{return null;}
      
      private function setFullPropContent(param1:String) : DisplayObject{return null;}
      
      private function cleanContent() : void{}
      
      private function showTip(param1:DisplayObject, param2:Boolean = false, param3:Number = 0.3) : void{}
      
      public function show(param1:String, param2:int = 0, param3:Boolean = false, param4:Number = 0.3) : void{}
      
      private function onTipToCenter(param1:DisplayObject) : void{}
      
      public function kill() : void{}
      
      public function hide(param1:DisplayObject) : void{}
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ItemManager;
import ddt.manager.LanguageMgr;
import flash.display.Sprite;

class EmptyGridMsgHolder extends Sprite
{
    
   
   private var _textField:FilterFrameText;
   
   private var _item:PropHolder;
   
   function EmptyGridMsgHolder(){super();}
   
   public function setContent(param1:String) : void{}
}

import bagAndInfo.cell.BaseCell;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.data.goods.ItemTemplateInfo;
import flash.display.DisplayObject;
import flash.display.Sprite;

class PropHolder extends Sprite
{
    
   
   private var _itemCell:BaseCell;
   
   private var _fore:DisplayObject;
   
   private var _nameField:FilterFrameText;
   
   function PropHolder(){super();}
   
   public function setInfo(param1:ItemTemplateInfo) : void{}
}
