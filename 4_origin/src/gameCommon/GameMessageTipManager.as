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
      
      public function GameMessageTipManager()
      {
         super();
         _tipContainer = new Sprite();
         var _loc1_:Boolean = false;
         _tipContainer.mouseEnabled = _loc1_;
         _tipContainer.mouseChildren = _loc1_;
         _tipContainer.y = StageReferance.stageHeight >> 1;
         _messageTip = new Sprite();
         _tipBg = UICreatShortcut.creatAndAdd("core.Scale9CornerImage23",_tipContainer);
         _tipText = UICreatShortcut.creatAndAdd("core.messageTip.TipText",_messageTip);
         _tipText.filters = ComponentFactory.Instance.creatFilters("core.messageTip.TipTextFilter_1");
         _tipText.antiAliasType = "advanced";
         _loc1_ = false;
         _messageTip.mouseEnabled = _loc1_;
         _tipText.mouseEnabled = _loc1_;
         _messageTip.mouseChildren = false;
         _ghostPropContent = new PropMessageHolder();
         _ghostPropContent.x = 130;
         _ghostPropContent.y = 10;
      }
      
      public static function getInstance() : GameMessageTipManager
      {
         if(instance == null)
         {
            instance = new GameMessageTipManager();
         }
         return instance;
      }
      
      private function setGhostPropContent(param1:String) : DisplayObject
      {
         cleanContent();
         _ghostPropContent.setContent(param1);
         _tipBg.width = _ghostPropContent.width + 260;
         _tipBg.height = _ghostPropContent.height + 20;
         _tipBg.x = StageReferance.stageWidth - _tipBg.width >> 1;
         _ghostPropContent.x = _tipBg.x + 130;
         _tipContainer.addChild(_tipBg);
         _tipContainer.addChild(_ghostPropContent);
         return _tipContainer;
      }
      
      private function setAutoUsePropContent(param1:String) : DisplayObject
      {
         cleanContent();
         _autoUsePropContent.setContent(param1);
         _tipBg.width = _autoUsePropContent.width + 260;
         _tipBg.height = _autoUsePropContent.height + 20;
         _tipBg.x = StageReferance.stageWidth - _tipBg.width >> 1;
         _autoUsePropContent.x = _tipBg.x + 130;
         _tipContainer.addChild(_tipBg);
         _tipContainer.addChild(_autoUsePropContent);
         return _tipContainer;
      }
      
      private function cleanContent() : void
      {
         while(_tipContainer.numChildren > 0)
         {
            _tipContainer.removeChildAt(0);
         }
      }
      
      private function showTip(param1:DisplayObject, param2:Boolean = false, param3:Number = 0.3) : void
      {
         if(!param2 && _isPlaying)
         {
            return;
         }
         if(_tipContainer.parent && _isPlaying)
         {
            TweenMax.killChildTweensOf(_tipContainer.parent);
         }
         _isPlaying = true;
         _duration = param3;
         var _loc4_:int = (StageReferance.stageHeight - param1.height) / 2 - 10;
         TweenMax.fromTo(param1,0.3,{
            "y":StageReferance.stageHeight / 2 + 20,
            "alpha":0,
            "ease":Quint.easeIn,
            "onComplete":onTipToCenter,
            "onCompleteParams":[param1]
         },{
            "y":_loc4_,
            "alpha":1
         });
         LayerManager.Instance.addToLayer(param1,1,false,0,false);
      }
      
      public function show(param1:String, param2:int = 0, param3:Boolean = false, param4:Number = 0.3) : void
      {
         var _loc5_:* = null;
         if(!param3 && _isPlaying)
         {
            return;
         }
         _tipString = param1;
         switch(int(param2) - 1)
         {
            case 0:
               _loc5_ = setGhostPropContent(param1);
               break;
            case 1:
               break;
            case 2:
               _loc5_ = setAutoUsePropContent(param1);
         }
         showTip(_loc5_,param3,param4);
      }
      
      private function onTipToCenter(param1:DisplayObject) : void
      {
         TweenMax.to(param1,_duration,{
            "alpha":0,
            "ease":Quint.easeOut,
            "onComplete":hide,
            "onCompleteParams":[param1],
            "delay":1.2
         });
      }
      
      public function hide(param1:DisplayObject) : void
      {
         _isPlaying = false;
         _tipString = null;
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         TweenMax.killTweensOf(param1);
      }
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
   
   function PropMessageHolder()
   {
      super();
      mouseEnabled = false;
      mouseChildren = false;
      _head = new HeadHolder();
      addChild(_head);
      _textField = ComponentFactory.Instance.creatComponentByStylename("MessageTip.TextField");
      _textField.text = LanguageMgr.GetTranslation("tank.MessageTip.GhostProp");
      addChild(_textField);
      _item = new PropHolder();
      addChild(_item);
   }
   
   public function setContent(param1:String) : void
   {
      var _loc2_:Array = param1.split("|");
      var _loc4_:Living = GameControl.Instance.Current.findLiving(_loc2_[0]);
      _head.setInfo(_loc4_);
      var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc2_[1]);
      _item.setInfo(_loc3_);
      _textField.x = _head.width - 3;
      _item.x = _textField.x + _textField.width - 4;
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

class AutoUsePropMessage extends Sprite
{
    
   
   private var _head:HeadHolder;
   
   private var _textField:FilterFrameText;
   
   private var _item:PropHolder;
   
   function AutoUsePropMessage()
   {
      super();
      mouseEnabled = false;
      mouseChildren = false;
      _head = new HeadHolder(false);
      addChild(_head);
      _textField = ComponentFactory.Instance.creatComponentByStylename("MessageTip.TextField");
      addChild(_textField);
      _item = new PropHolder();
      addChild(_item);
   }
   
   public function setContent(param1:String) : void
   {
      var _loc3_:Living = GameControl.Instance.Current.findLiving(int(param1));
      _head.setInfo(_loc3_);
      var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(10029);
      _item.setInfo(_loc2_);
      _textField.x = _head.width - 3;
      _textField.text = _loc3_.name + LanguageMgr.GetTranslation("tank.MessageTip.AutoGuide");
      _item.x = _textField.x + _textField.width - 4;
   }
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
   
   function PropHolder()
   {
      super();
      _itemCell = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.back"),null,false,false);
      addChild(_itemCell);
      _fore = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.fore");
      var _loc1_:int = 1;
      _fore.y = _loc1_;
      _fore.x = _loc1_;
      addChild(_fore);
      _nameField = ComponentFactory.Instance.creatComponentByStylename("MessageTip.Prop.TextField");
      addChild(_nameField);
   }
   
   public function setInfo(param1:ItemTemplateInfo) : void
   {
      _nameField.text = param1.Name;
      _itemCell.x = _nameField.x + _nameField.textWidth + 4;
      _fore.x = _itemCell.x + 1;
      _itemCell.info = param1;
   }
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
   
   function HeadHolder(param1:Boolean = true)
   {
      _drawRect = new Rectangle(0,0,36,36);
      _drawMatrix = new Matrix();
      super();
      _back = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.back");
      addChild(_back);
      _buff = new BitmapData(36,36,true,0);
      _headShape = new Shape();
      var _loc2_:Graphics = _headShape.graphics;
      _loc2_.beginBitmapFill(_buff);
      _loc2_.drawRect(0,0,36,36);
      _loc2_.endFill();
      if(param1)
      {
         _headShape.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
      }
      addChild(_headShape);
      _fore = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.fore");
      var _loc3_:int = 1;
      _fore.y = _loc3_;
      _fore.x = _loc3_;
      addChild(_fore);
      _nameField = ComponentFactory.Instance.creatComponentByStylename("MessageTip.GhostProp.NameField");
      addChild(_nameField);
   }
   
   public function setInfo(param1:Living) : void
   {
      _buff.fillRect(_drawRect,0);
      var _loc2_:Rectangle = getHeadRect(param1);
      _drawMatrix.identity();
      _drawMatrix.scale(_buff.width / _loc2_.width,_buff.height / _loc2_.height);
      _drawMatrix.translate(-_loc2_.x * _drawMatrix.a + 4,-_loc2_.y * _drawMatrix.d + 6);
      _buff.draw((param1.character as ShowCharacter).characterBitmapdata,_drawMatrix);
      if(param1.playerInfo != null)
      {
         _nameField.text = param1.playerInfo.NickName;
      }
      else
      {
         _nameField.text = param1.name;
      }
      _nameField.setFrame(param1.team);
   }
   
   private function getHeadRect(param1:Living) : Rectangle
   {
      if(param1.playerInfo.getShowSuits() && param1.playerInfo.getSuitsType() == 1)
      {
         return new Rectangle(21,12,167,165);
      }
      return new Rectangle(16,58,170,170);
   }
   
   public function hide() : void
   {
   }
   
   public function dispose() : void
   {
   }
}
