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
      
      public function simpleHelpButton($parent:Sprite, $buttonStyleName:String, $buttonInfo:Object = null, $titleText:String = "", $content:Object = null, $width:Number = 0, $height:Number = 0, $isShowContentBg:Boolean = true, $isShow:Boolean = true, $alertInfo:Object = null, $showLayerType:int = 2) : *
      {
         var helpFrameData:* = null;
         var helpButton:* = ComponentFactory.Instance.creat($buttonStyleName);
         if($buttonInfo)
         {
            if($buttonInfo is Point)
            {
               helpButton.x = $buttonInfo.x;
               helpButton.y = $buttonInfo.y;
            }
            else if($buttonInfo is String)
            {
               PositionUtils.setPos(helpButton,$buttonInfo);
            }
            else
            {
               var _loc16_:int = 0;
               var _loc15_:* = $buttonInfo;
               for(var buttonInfokey in $buttonInfo)
               {
                  helpButton[buttonInfokey] = $buttonInfo[buttonInfokey];
               }
            }
         }
         if($content)
         {
            helpFrameData = {
               "titleText":$titleText,
               "content":$content,
               "width":$width,
               "height":$height,
               "isShowContentBg":$isShowContentBg,
               "isShow":$isShow,
               "alertInfo":$alertInfo,
               "showLayerType":$showLayerType
            };
            helpButton.tipData = {"helpFrameData":helpFrameData};
            helpButton.addEventListener("click",__helpButtonClick);
            helpButton.addEventListener("dispose",__helpButtonDispose);
         }
         if($parent)
         {
            if($parent is Frame)
            {
               Frame($parent).addToContent(helpButton);
            }
            else
            {
               $parent.addChild(helpButton);
            }
         }
         return helpButton;
      }
      
      private function __helpButtonClick(event:MouseEvent) : void
      {
         var helpFrameData:* = null;
         SoundManager.instance.playButtonSound();
         if(event.currentTarget.hasOwnProperty("tipData") && event.currentTarget.tipData && event.currentTarget.tipData.helpFrameData)
         {
            helpFrameData = event.currentTarget.tipData.helpFrameData;
            simpleHelpFrame(helpFrameData.titleText,helpFrameData.content,helpFrameData.width,helpFrameData.height,helpFrameData.isShowContentBg,helpFrameData.isShow,helpFrameData.alertInfo,helpFrameData.showLayerType);
         }
         else
         {
            trace("HelpFrameUtils.simpleHelpButton->__helpButtonClick error!!!");
         }
      }
      
      private function __helpButtonDispose(event:ComponentEvent) : void
      {
         event.currentTarget.removeEventListener("click",__helpButtonClick);
         event.currentTarget.removeEventListener("dispose",__helpButtonDispose);
      }
      
      public function simpleHelpFrame($titleText:String, $content:Object, $width:Number, $height:Number, $isShowContentBg:Boolean = true, $isShow:Boolean = true, $alertInfo:Object = null, $showLayerType:int = 3) : BaseAlerFrame
      {
         var _bgHelp:* = null;
         var contentIndex:int = 0;
         var contentObj:* = null;
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.sound = "008";
         alertInfo.mutiline = true;
         alertInfo.buttonGape = 15;
         alertInfo.autoDispose = true;
         alertInfo.showCancel = false;
         alertInfo.moveEnable = true;
         alertInfo.escEnable = true;
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         if($alertInfo)
         {
            if($alertInfo is AlertInfo)
            {
               ObjectUtils.copyProperties(alertInfo,$alertInfo);
            }
            else
            {
               var _loc16_:int = 0;
               var _loc15_:* = $alertInfo;
               for(var alertInfokey in $alertInfo)
               {
                  alertInfo[alertInfokey] = $alertInfo[alertInfokey];
               }
            }
         }
         var _helpFrame:BaseAlerFrame = ComponentFactory.Instance.creatComponentByStylename("BaseFrame");
         _helpFrame.info = alertInfo;
         _helpFrame.moveInnerRectString = "0,30,0,30,1";
         _helpFrame.width = $width;
         _helpFrame.height = $height;
         _helpFrame.titleText = $titleText;
         _helpFrame.addEventListener("response",__helpFrameRespose);
         if($isShowContentBg)
         {
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("core.Scale9CornerImage.scale9CornerImagereleaseContentTextBG");
            _bgHelp.width = _helpFrame.width - 30;
            _bgHelp.height = _helpFrame.height - 98;
            _bgHelp.x = (_helpFrame.width - _bgHelp.width) / 2;
            _bgHelp.y = 40;
            _helpFrame.addToContent(_bgHelp);
         }
         if($content is DisplayObject)
         {
            _helpFrame.addToContent($content as DisplayObject);
         }
         else if($content is Array)
         {
            for(contentIndex = 0; contentIndex < $content.length; )
            {
               contentObj = $content[contentIndex];
               if(contentObj is DisplayObject)
               {
                  _helpFrame.addToContent(contentObj as DisplayObject);
               }
               else
               {
                  _helpFrame.addToContent(ComponentFactory.Instance.creat(contentObj as String));
               }
               contentIndex++;
            }
         }
         else
         {
            _helpFrame.addToContent(ComponentFactory.Instance.creat($content as String));
         }
         if($isShow)
         {
            LayerManager.Instance.addToLayer(_helpFrame,$showLayerType,true,2);
         }
         return _helpFrame;
      }
      
      private function __helpFrameRespose(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            event.currentTarget.removeEventListener("response",__helpFrameRespose);
            event.currentTarget.dispose();
         }
      }
   }
}
