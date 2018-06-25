package godsRoads.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import godsRoads.data.GodsRoadsMissionVo;
   import godsRoads.manager.GodsRoadsManager;
   import godsRoads.model.GodsRoadsModel;
   
   public class GodsRoadsMisstionCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:GodsRoadsMissionVo;
      
      private var _missionTxt:FilterFrameText;
      
      private var _model:GodsRoadsModel;
      
      private var lightIcon:Bitmap;
      
      private var grayIcon:Bitmap;
      
      public function GodsRoadsMisstionCell()
      {
         _model = GodsRoadsManager.instance._model;
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _line:Bitmap = ComponentFactory.Instance.creatBitmap("asset.godsRoads.underLine");
         addChild(_line);
         _missionTxt = ComponentFactory.Instance.creat("godsRoads.missionTxt");
         _missionTxt.mouseEnabled = true;
         addChild(_missionTxt);
         lightIcon = ComponentFactory.Instance.creatBitmap("asset.godsRoads.lightFinishIcon");
         grayIcon = ComponentFactory.Instance.creatBitmap("asset.godsRoads.grayFinishIcon");
         addChild(lightIcon);
         addChild(grayIcon);
         var mc:MovieClip = ComponentFactory.Instance.creat("godsRoads.ghostMask");
         mc.buttonMode = true;
         addChild(mc);
      }
      
      private function updateViewData() : void
      {
         if(_data.isFinished)
         {
            if(_data.isGetAwards)
            {
               _missionTxt.textFormatStyle = "godsRoads.TextFormat3";
               _missionTxt.filterString = "godsRoads.GF3";
               lightIcon.visible = false;
               grayIcon.visible = true;
            }
            else
            {
               _missionTxt.textFormatStyle = "godsRoads.TextFormat2";
               _missionTxt.filterString = "godsRoads.GF2";
               lightIcon.visible = true;
               grayIcon.visible = false;
            }
         }
         else
         {
            _missionTxt.textFormatStyle = "godsRoads.TextFormat1";
            _missionTxt.filterString = "godsRoads.GF1";
            lightIcon.visible = false;
            grayIcon.visible = false;
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value as GodsRoadsMissionVo;
         _missionTxt.text = _model.getMissionInfoById(_data.ID).conditiontTitle;
         updateViewData();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
