package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ToolPropTip extends BaseTip
   {
       
      
      private var _info:ItemTemplateInfo;
      
      private var _count:int = 0;
      
      private var _showTurn:Boolean;
      
      private var _showCount:Boolean;
      
      private var _showThew:Boolean;
      
      private var _bg:ScaleBitmapImage;
      
      private var context:TextField;
      
      private var thew_txt:FilterFrameText;
      
      private var turn_txt:FilterFrameText;
      
      private var description_txt:FilterFrameText;
      
      private var name_txt:FilterFrameText;
      
      private var _tempData:Object;
      
      private var f:TextFormat;
      
      private var _container:Sprite;
      
      public function ToolPropTip()
      {
         f = new TextFormat(null,13,16777215);
         super();
      }
      
      override protected function init() : void
      {
         name_txt = ComponentFactory.Instance.creat("core.ToolNameTxt");
         thew_txt = ComponentFactory.Instance.creat("core.ToolThewTxt");
         description_txt = ComponentFactory.Instance.creat("core.ToolDescribeTxt");
         turn_txt = ComponentFactory.Instance.creat("core.ToolGoldTxt");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _container = new Sprite();
         _container.addChild(thew_txt);
         _container.addChild(turn_txt);
         _container.addChild(description_txt);
         _container.addChild(name_txt);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         _container.mouseEnabled = false;
         _container.mouseChildren = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1 is ToolPropInfo)
         {
            this.visible = true;
            update(param1.showTurn,param1.showCount,param1.showThew,param1.valueType,param1.info,param1.count,param1.shortcutKey);
         }
         else
         {
            this.visible = false;
         }
         _tempData = param1;
      }
      
      public function changeStyle(param1:ItemTemplateInfo, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:* = 0;
         name_txt.width = _loc4_;
         _loc4_ = _loc4_;
         description_txt.width = _loc4_;
         _loc4_ = _loc4_;
         turn_txt.width = _loc4_;
         thew_txt.width = _loc4_;
         _loc4_ = 0;
         name_txt.y = _loc4_;
         _loc4_ = _loc4_;
         description_txt.y = _loc4_;
         _loc4_ = _loc4_;
         turn_txt.y = _loc4_;
         thew_txt.y = _loc4_;
         _loc4_ = "";
         name_txt.text = _loc4_;
         _loc4_ = _loc4_;
         description_txt.text = _loc4_;
         _loc4_ = _loc4_;
         turn_txt.text = _loc4_;
         thew_txt.text = _loc4_;
         if(!context)
         {
            context = new TextField();
            context.width = param2 - 2;
            context.autoSize = "center";
            _container.addChild(context);
            context = new TextField();
            context.width = param2 - 2;
            if(param3)
            {
               context.wordWrap = true;
               context.autoSize = "left";
               context.x = 2;
               context.y = 2;
            }
            else
            {
               context.wordWrap = false;
               context.autoSize = "center";
               context.y = 4;
            }
            _container.addChild(context);
         }
         _info = param1;
         if(_info)
         {
            context.text = _info.Description;
         }
         context.setTextFormat(f);
         _bg.height = 0;
         drawBG(param2);
      }
      
      private function update(param1:Boolean, param2:Boolean, param3:Boolean, param4:String, param5:ItemTemplateInfo, param6:int, param7:String) : void
      {
         _showCount = param2;
         _showTurn = param1;
         _showThew = param3;
         _info = param5;
         _count = param6;
         name_txt.autoSize = "left";
         if(_showCount)
         {
            if(_count > 1)
            {
               name_txt.text = String(_info.Name) + "(" + String(_count) + ")";
            }
            else if(_count == -1)
            {
               name_txt.text = String(_info.Name) + LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip.infinity");
            }
            else
            {
               name_txt.text = String(_info.Name);
            }
         }
         else
         {
            name_txt.text = String(_info.Name);
         }
         if(param7)
         {
            name_txt.text = name_txt.text + (" [" + param7.toLocaleUpperCase() + "]");
         }
         if(_showThew)
         {
            if(param4 == "Psychic")
            {
               thew_txt.htmlText = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip." + param4,String(_info.Property7));
            }
            else if(param4 == "Energy")
            {
               thew_txt.htmlText = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip." + param4,String(_info.Property4));
            }
            else if(param4 == "mp")
            {
               thew_txt.htmlText = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip." + param4,String(_info.Property4));
            }
            else if(param4 == "max")
            {
               thew_txt.htmlText = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip.remained");
            }
            else
            {
               thew_txt.text = "";
            }
            description_txt.y = thew_txt.y + thew_txt.height;
            thew_txt.visible = true;
         }
         else
         {
            thew_txt.visible = false;
            description_txt.y = thew_txt.y;
         }
         description_txt.autoSize = "none";
         description_txt.width = 150;
         description_txt.wordWrap = true;
         description_txt.autoSize = "left";
         description_txt.htmlText = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip.Description",_info.Description);
         if(_showTurn)
         {
            turn_txt.visible = true;
            turn_txt.y = description_txt.y + description_txt.height + 5;
            turn_txt.text = LanguageMgr.GetTranslation("tank.game.actions.cooldown") + ": " + _info.Property1 + LanguageMgr.GetTranslation("tank.game.actions.turn");
         }
         else
         {
            turn_txt.visible = false;
            turn_txt.y = 0;
         }
         drawBG();
      }
      
      private function reset() : void
      {
         _bg.height = 0;
         _bg.width = 0;
      }
      
      private function drawBG(param1:int = 0) : void
      {
         reset();
         if(param1 == 0)
         {
            _bg.width = _container.width + 10;
            _bg.height = _container.height + 6;
         }
         else
         {
            _bg.width = param1 + 2;
            _bg.height = _container.height + 5;
         }
         _width = _bg.width;
         _height = _bg.height;
      }
      
      override public function dispose() : void
      {
         if(context && context.parent)
         {
            context.parent.removeChild(context);
         }
         context = null;
         _info = null;
         ObjectUtils.disposeObject(thew_txt);
         thew_txt = null;
         ObjectUtils.disposeObject(turn_txt);
         turn_txt = null;
         ObjectUtils.disposeObject(description_txt);
         description_txt = null;
         ObjectUtils.disposeObject(name_txt);
         name_txt = null;
         ObjectUtils.disposeObject(this);
      }
   }
}
