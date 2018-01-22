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
      
      public function MessageTipManager()
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
         _emptyGridContent = new EmptyGridMsgHolder();
         _emptyGridContent.x = 130;
         _emptyGridContent.y = 10;
         App.stage.addEventListener("APP_DDT_MSG",__onShowMornUIMessage);
      }
      
      public static function getInstance() : MessageTipManager
      {
         if(instance == null)
         {
            instance = new MessageTipManager();
         }
         return instance;
      }
      
      private function __onShowMornUIMessage(param1:UIEvent) : void
      {
         show(param1.data);
      }
      
      public function get currentType() : int
      {
         return _currentType;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      private function setContent(param1:String) : DisplayObject
      {
         cleanContent();
         _tipString = param1;
         _tipText.autoSize = "center";
         _tipText.text = _tipString;
         _tipBg.width = _tipText.textWidth + 260;
         _tipBg.height = _tipText.textHeight + 20;
         _tipBg.x = StageReferance.stageWidth - _tipBg.width >> 1;
         _tipContainer.addChild(_tipBg);
         _tipContainer.addChild(_messageTip);
         return _tipContainer;
      }
      
      private function setFullPropContent(param1:String) : DisplayObject
      {
         cleanContent();
         _emptyGridContent.setContent(param1);
         _tipBg.width = _emptyGridContent.width + 260;
         _tipBg.height = _emptyGridContent.height + 20;
         _tipBg.x = StageReferance.stageWidth - _tipBg.width >> 1;
         _emptyGridContent.x = _tipBg.x + 130;
         _tipContainer.addChild(_tipBg);
         _tipContainer.addChild(_emptyGridContent);
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
               break;
            case 1:
               _loc5_ = setFullPropContent(param1);
               break;
            case 2:
         }
         _currentType = param2;
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
      
      public function kill() : void
      {
         _isPlaying = false;
         if(_tipContainer.parent)
         {
            _tipContainer.parent.removeChild(_tipContainer);
         }
         TweenMax.killTweensOf(_tipContainer);
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

class EmptyGridMsgHolder extends Sprite
{
    
   
   private var _textField:FilterFrameText;
   
   private var _item:PropHolder;
   
   function EmptyGridMsgHolder()
   {
      super();
      mouseEnabled = false;
      mouseChildren = false;
      _textField = ComponentFactory.Instance.creatComponentByStylename("MessageTip.TextField");
      _textField.x = 0;
      _textField.text = LanguageMgr.GetTranslation("tank.MessageTip.EmptyGrid");
      addChild(_textField);
      _item = new PropHolder();
      addChild(_item);
   }
   
   public function setContent(param1:String) : void
   {
      var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(param1));
      _item.setInfo(_loc2_);
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
