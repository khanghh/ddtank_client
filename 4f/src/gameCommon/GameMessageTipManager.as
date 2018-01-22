package gameCommon
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
   
   public class GameMessageTipManager
   {
      
      private static var instance:GameMessageTipManager;
       
      
      private var _messageTip:Sprite;
      
      private var _tipString:String;
      
      private var _tipText:FilterFrameText;
      
      private var _tipBg:DisplayObject;
      
      private var _isPlaying:Boolean;
      
      private var _ghostPropContent:PropMessageHolder;
      
      private var _autoUsePropContent:AutoUsePropMessage;
      
      private var _tipContainer:Sprite;
      
      private var _duration:Number;
      
      public function GameMessageTipManager(){super();}
      
      public static function getInstance() : GameMessageTipManager{return null;}
      
      private function setGhostPropContent(param1:String) : DisplayObject{return null;}
      
      private function setAutoUsePropContent(param1:String) : DisplayObject{return null;}
      
      private function cleanContent() : void{}
      
      private function showTip(param1:DisplayObject, param2:Boolean = false, param3:Number = 0.3) : void{}
      
      public function show(param1:String, param2:int = 0, param3:Boolean = false, param4:Number = 0.3) : void{}
      
      private function onTipToCenter(param1:DisplayObject) : void{}
      
      public function hide(param1:DisplayObject) : void{}
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ItemManager;
import ddt.manager.LanguageMgr;
import flash.display.Sprite;
import gameCommon.GameControl;
import gameCommon.model.Living;

class PropMessageHolder extends Sprite
{
    
   
   private var _head:HeadHolder;
   
   private var _textField:FilterFrameText;
   
   private var _item:PropHolder;
   
   function PropMessageHolder(){super();}
   
   public function setContent(param1:String) : void{}
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ItemManager;
import ddt.manager.LanguageMgr;
import flash.display.Sprite;
import gameCommon.GameControl;
import gameCommon.model.Living;

class AutoUsePropMessage extends Sprite
{
    
   
   private var _head:HeadHolder;
   
   private var _textField:FilterFrameText;
   
   private var _item:PropHolder;
   
   function AutoUsePropMessage(){super();}
   
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

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.view.character.ShowCharacter;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import gameCommon.model.Living;

class HeadHolder extends Sprite implements Disposeable
{
    
   
   private var _back:DisplayObject;
   
   private var _fore:DisplayObject;
   
   private var _headShape:Shape;
   
   private var _buff:BitmapData;
   
   private var _drawRect:Rectangle;
   
   private var _drawMatrix:Matrix;
   
   private var _nameField:FilterFrameText;
   
   function HeadHolder(param1:Boolean = true){super();}
   
   public function setInfo(param1:Living) : void{}
   
   private function getHeadRect(param1:Living) : Rectangle{return null;}
   
   public function hide() : void{}
   
   public function dispose() : void{}
}
