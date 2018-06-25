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
      
      private function setGhostPropContent(str:String) : DisplayObject
      {
         cleanContent();
         _ghostPropContent.setContent(str);
         _tipBg.width = _ghostPropContent.width + 260;
         _tipBg.height = _ghostPropContent.height + 20;
         _tipBg.x = StageReferance.stageWidth - _tipBg.width >> 1;
         _ghostPropContent.x = _tipBg.x + 130;
         _tipContainer.addChild(_tipBg);
         _tipContainer.addChild(_ghostPropContent);
         return _tipContainer;
      }
      
      private function setAutoUsePropContent(playerID:String) : DisplayObject
      {
         cleanContent();
         _autoUsePropContent.setContent(playerID);
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
      
      private function showTip(tipContent:DisplayObject, replace:Boolean = false, duration:Number = 0.3) : void
      {
         if(!replace && _isPlaying)
         {
            return;
         }
         if(_tipContainer.parent && _isPlaying)
         {
            TweenMax.killChildTweensOf(_tipContainer.parent);
         }
         _isPlaying = true;
         _duration = duration;
         var tempY:int = (StageReferance.stageHeight - tipContent.height) / 2 - 10;
         TweenMax.fromTo(tipContent,0.3,{
            "y":StageReferance.stageHeight / 2 + 20,
            "alpha":0,
            "ease":Quint.easeIn,
            "onComplete":onTipToCenter,
            "onCompleteParams":[tipContent]
         },{
            "y":tempY,
            "alpha":1
         });
         LayerManager.Instance.addToLayer(tipContent,1,false,0,false);
      }
      
      public function show(str:String, type:int = 0, replace:Boolean = false, duration:Number = 0.3) : void
      {
         var content:* = null;
         if(!replace && _isPlaying)
         {
            return;
         }
         _tipString = str;
         switch(int(type) - 1)
         {
            case 0:
               content = setGhostPropContent(str);
               break;
            case 1:
               break;
            case 2:
               content = setAutoUsePropContent(str);
         }
         showTip(content,replace,duration);
      }
      
      private function onTipToCenter(content:DisplayObject) : void
      {
         TweenMax.to(content,_duration,{
            "alpha":0,
            "ease":Quint.easeOut,
            "onComplete":hide,
            "onCompleteParams":[content],
            "delay":1.2
         });
      }
      
      public function hide(content:DisplayObject) : void
      {
         _isPlaying = false;
         _tipString = null;
         if(content.parent)
         {
            content.parent.removeChild(content);
         }
         TweenMax.killTweensOf(content);
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
   
   public function setContent(str:String) : void
   {
      var arr:Array = str.split("|");
      var living:Living = GameControl.Instance.Current.findLiving(arr[0]);
      _head.setInfo(living);
      var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(arr[1]);
      _item.setInfo(item);
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
   
   public function setContent(id:String) : void
   {
      var living:Living = GameControl.Instance.Current.findLiving(int(id));
      _head.setInfo(living);
      var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(10029);
      _item.setInfo(item);
      _textField.x = _head.width - 3;
      _textField.text = living.name + LanguageMgr.GetTranslation("tank.MessageTip.AutoGuide");
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
   
   public function setInfo(item:ItemTemplateInfo) : void
   {
      _nameField.text = item.Name;
      _itemCell.x = _nameField.x + _nameField.textWidth + 4;
      _fore.x = _itemCell.x + 1;
      _itemCell.info = item;
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
   
   function HeadHolder(isDeath:Boolean = true)
   {
      _drawRect = new Rectangle(0,0,36,36);
      _drawMatrix = new Matrix();
      super();
      _back = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.back");
      addChild(_back);
      _buff = new BitmapData(36,36,true,0);
      _headShape = new Shape();
      var pen:Graphics = _headShape.graphics;
      pen.beginBitmapFill(_buff);
      pen.drawRect(0,0,36,36);
      pen.endFill();
      if(isDeath)
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
   
   public function setInfo(living:Living) : void
   {
      _buff.fillRect(_drawRect,0);
      var rect:Rectangle = getHeadRect(living);
      _drawMatrix.identity();
      _drawMatrix.scale(_buff.width / rect.width,_buff.height / rect.height);
      _drawMatrix.translate(-rect.x * _drawMatrix.a + 4,-rect.y * _drawMatrix.d + 6);
      _buff.draw((living.character as ShowCharacter).characterBitmapdata,_drawMatrix);
      if(living.playerInfo != null)
      {
         _nameField.text = living.playerInfo.NickName;
      }
      else
      {
         _nameField.text = living.name;
      }
      _nameField.setFrame(living.team);
   }
   
   private function getHeadRect(living:Living) : Rectangle
   {
      if(living.playerInfo.getShowSuits() && living.playerInfo.getSuitsType() == 1)
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
