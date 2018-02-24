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
      
      public function GodsRoadsMisstionCell(){super();}
      
      private function initView() : void{}
      
      private function updateViewData() : void{}
      
      public function dispose() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
