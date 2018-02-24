package ddt.utils
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HelpFrameUtils
   {
      
      private static var _instance:HelpFrameUtils;
       
      
      public function HelpFrameUtils()
      {
         super();
      }
      
      public static function get Instance() : HelpFrameUtils
      {
         if(_instance == null)
         {
            _instance = new HelpFrameUtils();
         }
         return _instance;
      }
      
      public function simpleHelpButton(param1:Sprite, param2:String, param3:Object = null, param4:String = "", param5:Object = null, param6:Number = 0, param7:Number = 0, param8:Boolean = true, param9:Boolean = true, param10:Object = null, param11:int = 2) : *
      {
         var _loc14_:* = null;
         var _loc13_:* = ComponentFactory.Instance.creat(param2);
         if(param3)
         {
            if(param3 is Point)
            {
               _loc13_.x = param3.x;
               _loc13_.y = param3.y;
            }
            else if(param3 is String)
            {
               PositionUtils.setPos(_loc13_,param3);
            }
            else
            {
               var _loc16_:int = 0;
               var _loc15_:* = param3;
               for(var _loc12_ in param3)
               {
                  _loc13_[_loc12_] = param3[_loc12_];
               }
            }
         }
         if(param5)
         {
            _loc14_ = {
               "titleText":param4,
               "content":param5,
               "width":param6,
               "height":param7,
               "isShowContentBg":param8,
               "isShow":param9,
               "alertInfo":param10,
               "showLayerType":param11
            };
            _loc13_.tipData = {"helpFrameData":_loc14_};
            _loc13_.addEventListener("click",__helpButtonClick);
            _loc13_.addEventListener("dispose",__helpButtonDispose);
         }
         if(param1)
         {
            if(param1 is Frame)
            {
               Frame(param1).addToContent(_loc13_);
            }
            else
            {
               param1.addChild(_loc13_);
            }
         }
         return _loc13_;
      }
      
      private function __helpButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(param1.currentTarget.hasOwnProperty("tipData") && param1.currentTarget.tipData && param1.currentTarget.tipData.helpFrameData)
         {
            _loc2_ = param1.currentTarget.tipData.helpFrameData;
            simpleHelpFrame(_loc2_.titleText,_loc2_.content,_loc2_.width,_loc2_.height,_loc2_.isShowContentBg,_loc2_.isShow,_loc2_.alertInfo,_loc2_.showLayerType);
         }
         else
         {
            trace("HelpFrameUtils.simpleHelpButton->__helpButtonClick error!!!");
         }
      }
      
      private function __helpButtonDispose(param1:ComponentEvent) : void
      {
         param1.currentTarget.removeEventListener("click",__helpButtonClick);
         param1.currentTarget.removeEventListener("dispose",__helpButtonDispose);
      }
      
      public function simpleHelpFrame(param1:String, param2:Object, param3:Number, param4:Number, param5:Boolean = true, param6:Boolean = true, param7:Object = null, param8:int = 3) : BaseAlerFrame
      {
         var _loc12_:* = null;
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc14_:AlertInfo = new AlertInfo();
         _loc14_.sound = "008";
         _loc14_.mutiline = true;
         _loc14_.buttonGape = 15;
         _loc14_.autoDispose = true;
         _loc14_.showCancel = false;
         _loc14_.moveEnable = true;
         _loc14_.escEnable = true;
         _loc14_.submitLabel = LanguageMgr.GetTranslation("ok");
         if(param7)
         {
            if(param7 is AlertInfo)
            {
               ObjectUtils.copyProperties(_loc14_,param7);
            }
            else
            {
               var _loc16_:int = 0;
               var _loc15_:* = param7;
               for(var _loc11_ in param7)
               {
                  _loc14_[_loc11_] = param7[_loc11_];
               }
            }
         }
         var _loc13_:BaseAlerFrame = ComponentFactory.Instance.creatComponentByStylename("BaseFrame");
         _loc13_.info = _loc14_;
         _loc13_.moveInnerRectString = "0,30,0,30,1";
         _loc13_.width = param3;
         _loc13_.height = param4;
         _loc13_.titleText = param1;
         _loc13_.addEventListener("response",__helpFrameRespose);
         if(param5)
         {
            _loc12_ = ComponentFactory.Instance.creatComponentByStylename("core.Scale9CornerImage.scale9CornerImagereleaseContentTextBG");
            _loc12_.width = _loc13_.width - 30;
            _loc12_.height = _loc13_.height - 98;
            _loc12_.x = (_loc13_.width - _loc12_.width) / 2;
            _loc12_.y = 40;
            _loc13_.addToContent(_loc12_);
         }
         if(param2 is DisplayObject)
         {
            _loc13_.addToContent(param2 as DisplayObject);
         }
         else if(param2 is Array)
         {
            _loc10_ = 0;
            while(_loc10_ < param2.length)
            {
               _loc9_ = param2[_loc10_];
               if(_loc9_ is DisplayObject)
               {
                  _loc13_.addToContent(_loc9_ as DisplayObject);
               }
               else
               {
                  _loc13_.addToContent(ComponentFactory.Instance.creat(_loc9_ as String));
               }
               _loc10_++;
            }
         }
         else
         {
            _loc13_.addToContent(ComponentFactory.Instance.creat(param2 as String));
         }
         if(param6)
         {
            LayerManager.Instance.addToLayer(_loc13_,param8,true,2);
         }
         return _loc13_;
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            param1.currentTarget.removeEventListener("response",__helpFrameRespose);
            param1.currentTarget.dispose();
         }
      }
   }
}
