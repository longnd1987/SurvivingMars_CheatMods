(C) means it's a c function, and I don't know the args
__DumpObjPropsForSave()
AABBTestAABB(b, ptCenter1, nRadius1)
AABBTestSphere(b, ptCenter1, nRadius1)
abs(nValue)
AddPathTrace(src, dst, step)
AddRects(b1, b2)
Advance(utf8, pointer, letters)
AngleNormalize(angle)
AppendStream(handle, pstr, sound_type, samples_per_sec, bits_per_sample, channels, max_silence, fade_time, volume)
asin(nValue)
AsyncCompress(C)
AsyncCopyFile(src, dst, mode)
AsyncCreatePath(path)
AsyncDecompress(C)
AsyncExec(cmd, working_dir, hidden, capture_output, priority)
AsyncFileClose(file)
AsyncFileDelete(path)
AsyncFileFlush(file)
AsyncFileOpen(filename, mode, create_path)
AsyncFileRead(file, count, offset, mode)
AsyncFileRename(C)
AsyncFileToString(filename, count, offset, mode, raw)
AsyncFileWrite(file, data, offset, flush)
AsyncFindSmoothPath(C)
AsyncGetFileAttribute(filename, attribute)
AsyncGetSourceInfo(path, rev_type, query_key)
AsyncIntersectConeWithObstacles(C)
AsyncIntersectCylinderWithObstacles(C)
AsyncLerpHeatGrid(C)
AsyncListFiles(path, mask, mode)
AsyncLoadAdditionalEntities(C)
AsyncLoadGrass(C)
AsyncMountPack(mountpoint_or_label, pack, options, mem)
AsyncOrbisGetAuthCode()
AsyncOrbisGetUnlockedTrophies()
AsyncOrbisSaveDataCreate(mountpoint, display_name, files, size)
AsyncOrbisSaveDataDelete(mountpoint)
AsyncOrbisSaveDataList()
AsyncOrbisSaveDataReadOnlyMount(filename)
AsyncOrbisSaveDataUnmount(mountpoint)
AsyncOrbisShowBrowserDialog()
AsyncOrbisUnlockTrophy(id)
AsyncPack(packfile, paths, remove_folders)
AsyncPSNGetAppTicket()
AsyncRand(nMax)
AsyncSaveGrass(C)
AsyncSetFileAttribute(C)
AsyncSetHeightGrid(C)
AsyncSetTerrainGrid(C)
AsyncSetTypeGrid(C)
AsyncStringToFile(filename, data, offset, timestamp, compression)
AsyncUnmount(path)
AsyncUnpack(packfile, dest)
AsyncWebRequest(params)
atan(mul, div)
band(n1, n2)
BinaryEscape(str, escape, compression, inplace)
bnot(n)
bor(n1, n2)
BoundSegmentInBox(pt1, pt2, box)
box(minx, miny, minz, maxx, maxy, maxz)
box:Center()
box:IsValid()
box:IsValidZ()
box:max()
box:maxx()
box:maxxyz()
box:maxy()
box:maxz()
box:min()
box:minx()
box:minxyz()
box:miny()
box:minz()
box:size()
box:sizex()
box:sizexyz()
box:sizey()
box:sizez()
box:xyxy()
boxdiag(minx, miny, minz, maxx, maxy, maxz)
BS3_GetMinCurveSpline2D(pos_start, dir_start, pos_end, dir_end)
BS3_GetSplineLength2D(spline, iterations)
BS3_GetSplineLengthEst(spline)
BS3_GetSplineToCircleDist2D(spline, center, radius, precision)
BS3_GetSplineToLineDist2D(spline, start_point, end_point, precision)
BS3_GetSplineToPointDist2D(spline, pos, precision)
BS3_GetSplineToSplineDist2D(spline1, spline2, precision)
BS3_IsSplineLinear2D(spline, max_angle)
BS3_IsSplineShorter2D(spline, length, iterations)
bxor(n1, n2)
CalcOrientation(p1, p2)
camera.Activate(C)
camera.AlignBehindCharacter(C)
camera.AttachObject(C)
camera.ClearLockedLookAt(C)
camera.DetachObject(C)
camera.DetachObjects(C)
camera.DisableController(C)
camera.DistanceAtPitch(C)
camera.EnableCollisionAdjust(C)
camera.EnableController(C)
camera.EnableFollow(C)
camera.EnableMouseControl(C)
camera.GetDirection()
camera.GetEye()
camera.GetEyeOffset(C)
camera.GetFollowPos(C)
camera.GetLockedLookAt(C)
camera.GetLookAt(C)
camera.GetLookAtOffset(C)
camera.GetPan(C)
camera.GetPitch()
camera.GetPitch(C)
camera.GetPos()
camera.GetRoll(C)
camera.GetRollOffset(C)
camera.GetViewArea()
camera.GetYaw()
camera.GetZoom(C)
camera.GetZoomTarget(C)
camera.IsActive(C)
camera.IsAttachedToObject(C)
camera.IsLocked(view)
camera.Lock(view)
camera.OverrideDefaultPitch(C)
camera.Reset(C)
camera.SetAutoRotate(C)
camera.SetDefaultView(C)
camera.SetEye(C)
camera.SetEyeOffset(C)
camera.SetLockedLookAt(C)
camera.SetLookAt(C)
camera.SetLookAtOffset(C)
camera.SetPan(C)
camera.SetRoll(C)
camera.SetRollOffset(C)
camera.SetZoom(C)
camera.Shake(CommonLua/Camera.lua)
camera.ShakeStop(CommonLua/Camera.lua)
camera.Unlock(view)
camera3p.Activate(view)
camera3p.AlignBehindCharacter(C)
camera3p.AttachObject(SelectedObj)
camera3p.ClearLockedLookAt(C)
camera3p.DetachObject(C)
camera3p.DetachObjects(C)
camera3p.DisableController(C)
camera3p.DistanceAtPitch(C)
camera3p.EnableCollisionAdjust(C)
camera3p.EnableController(C)
camera3p.EnableFollow(object)
camera3p.EnableMouseControl(C)
camera3p.GetEye()
camera3p.GetEyeOffset()
camera3p.GetFollowPos(C)
camera3p.GetLockedLookAt(C)
camera3p.GetLookAt()
camera3p.GetLookAtOffset()
camera3p.GetPan(C)
camera3p.GetPitch()
camera3p.GetRoll()
camera3p.GetRollOffset()
camera3p.GetYaw()
camera3p.GetZoom(C)
camera3p.GetZoomTarget(C)
camera3p.IsActive()
camera3p.IsAttachedToObject(C)
camera3p.OverrideDefaultPitch(C)
camera3p.Reset(C)
camera3p.SetAutoRotate(C)
camera3p.SetDefaultView(C)
camera3p.SetEye(eye_pos, time) --(point(SelectedObj:GetSpotLocPosXYZ()))
camera3p.SetEyeOffset(eye_offset, time)
camera3p.SetEyePrecise(eye_pos, time)
camera3p.SetLockedLookAt(C)
camera3p.SetLookAt(lookat_pos, time)
camera3p.SetLookAtOffset(lookat_pos_offset, time)
camera3p.SetLookAtPrecise(lookat_pos, time)
camera3p.SetPan(C)
camera3p.SetRoll(roll, time)
camera3p.SetRollOffset(roll_offset, time)
camera3p.SetZoom(C)
camera3p.Shake(CommonLua/Camera.lua(76)
camera3p.ShakeStop(CommonLua/Camera.lua(102)
cameraFly.Activate(view)
cameraFly.IsActive()
cameraFly.SetCamera(pos, look_at)
cameraMax.Activate(view)
cameraMax.GetPosLookAt(C)
cameraMax.IsActive()
cameraMax.SetAnimObj(C)
cameraMax.SetCamera(pos, look_at)
cameraMax.SetCameraEx(C)
cameraMax.SetCameraPrecise(C)
cameraMax.SetPositionLookatAndRoll(C)
cameraMax.Shake(CommonLua/Camera.lua(176)
cameraRTS.Activate(view)
cameraRTS.ClampCameraInMapBoundaries(C)
cameraRTS.ClampLookat(C)
cameraRTS.GetBorder(C)
cameraRTS.GetCameraRotation(C)
cameraRTS.GetEasingSpeed(C)
cameraRTS.GetEasingTime(C)
cameraRTS.GetEasingTime2D(C)
cameraRTS.GetEye(C)
cameraRTS.GetFramePosLookAt(C)
cameraRTS.GetHeight()
cameraRTS.GetHeightInterval()
cameraRTS.GetLockedZ(C)
cameraRTS.GetLookAt()
cameraRTS.GetLookatDist()
cameraRTS.GetPos()
cameraRTS.GetPosLookAt()
cameraRTS.GetProperties(C)
cameraRTS.GetRightUp(C)
cameraRTS.GetRotateCenter()
cameraRTS.GetRotationRadius()
cameraRTS.GetYaw()
cameraRTS.GetYawRestore()
cameraRTS.GetZoom()
cameraRTS.GetZoomLimits()
cameraRTS.InvertMouse(inv_x, inv_y)
cameraRTS.IsActive()
cameraRTS.IsMoving(C)
cameraRTS.Normalize(C)
cameraRTS.PrepareUnlocking(C)
cameraRTS.Rotate(C)
cameraRTS.SetCamera(pos, lookat, time, easingType)
cameraRTS.SetCameraPrecise(pos, lookat, time)
cameraRTS.SetLockedZ(C)
cameraRTS.SetProperties(view, prop)
cameraRTS.SetYawRestore(bRestore)
cameraRTS.SetYawRestore(C)
cameraRTS.SetZoom()
cameraRTS.SetZoomLimits()
CancelUpsampledScreenshot()
CanDestlock(pt, radius)
CanYield()
CatmullRomSpline(p1, p2, p3, p4, t, scale)
CertDelete(certificate_name)
CertRead(certificate_name, certificate_file)
CertRegister(certificate_name, certificate_data)
Clamp()
ClearObjects()
ColorDist(col1, col2)
Compress(str)
ConsolePrint(text)
ConvexHull2D(points, border)
CopyToClipboard(clip)
cos(nAngle)
CountObjects(query)
Crash()
CreateGameTimeThread(exec)
CreateRealTimeThread(exec)
Cross(pt1, pt2)
Cross2D(pt1, pt2)
CurrentThread()
DbgAddBox(box, color)
DbgAddCircle(center, radius, color, point_count)
DbgAddPoly(poly, color)
DbgAddSpline(spline, color, zplane)
DbgAddTerrainRect(rect, color)
DbgAddTriangle(pt1, pt2, pt3, color)
DbgAddVector(origin, vector, color)
DbgClearVectors()
dbgMemoryAllocationTest()
DbgSetVectorOffset(offset)
DebugPrint(text)
Decompress(str)
DecompressAndUnserialize(str)
DefMoveCamera(pos, yaw, dist_scale, pitch, rot_speed, move_speed, move_time, yaw_time, pitch_time)
DeleteThread(thread, allow_if_current)
DistSegmentToPt2D2(pt1, pt2, pt)
DivRound(m, d)
Dot(pt1, pt2)
Dot2D(pt1, pt2)
editor.AddToSel(ol)
editor.BegOperation(params)
editor.ChangeSelWithUndoRedo(sel)
editor.ClearDirtyFlag(mask)
editor.ClearSel()
editor.ClearSelWithUndoRedo()
editor.DelSelWithUndoRedo()
editor.EndOperation(id, objects)
editor.Enter()
editor.GetChangeHeightBrushMode()
editor.GetDirtyFlag(mask)
editor.GetDraggingObjects()
editor.GetLastPlacedObjects()
editor.GetRandomizeRotation()
editor.GetRandomizeSize()
editor.GetSel()
editor.GizmoGetMoveAxisX()
editor.GizmoGetMoveAxisY()
editor.GizmoGetMoveAxisZ()
editor.GizmoGetRotAxisX()
editor.GizmoGetRotAxisZ()
editor.GizmoGetRotRayToCenterAxis()
editor.GizmoGetRotScreenAxisX()
editor.GizmoGetRotScreenAxisY()
editor.GizmoMoveObjects(vecDir)
editor.GizmoMoveToggleLocalCoordinateSystem()
editor.GizmoRotateObjects(axis, angle)
editor.GizmoRotateToggleLocalCoordinateSystem()
editor.GizmoRotateToggleWorldDirections()
editor.IsGizmoMoveInLocalCoordinateSystem()
editor.IsGizmoRotateInLocalCoordinateSystem()
editor.IsGizmoRotateInWorldDirections()
editor.IsSelected(object)
editor.Leave()
editor.LoadEnrichTerrainTable()
editor.Redo()
editor.Reload()
editor.SetChangeHeightBrushMode(mode)
editor.SetNextObject()
editor.SetPrevObject()
editor.SetRandomizeRotation()
editor.SetRandomizeSize()
editor.Undo()
editor.VertexPushHeight(delta)
EndAAMotionBlurScreenshot(filename, samples)
EnumValidStates()
EnumVars(prefix)
ExpandPerlinParams(octaves, persistence, main_octave)
FileAgeOlderThanDays(filename, days)
FileSize(filename)
FilterObjects(query, list)
FindMinObject(query)
FindNearest(query, pt)
FindNearestObject(objlist, pt)
FullscreenMode()
GameTime()
GameToCamera(pt, camPos, camLookAt)
GameToScreen(pt)
GenerateBillboards()
GetAllEntities()
GetAppName()
GetAxisAngle(pt1, pt2)
GetCameraLH(pitch, dist, dist_to_ground)
GetClock()
GetCurrentDirectory()
GetCurrentPath()
GetCursorObjSel(screen_pos, objects_to_test, test_walkables)
GetCustomData(index)
GetCustomDataString(index1, index2)
GetDestlockablePointNearby(pt, radius, checkPassability)
GetEntityMaxSurfacesBox()
GetEntitySpotAngle(entity, idx)
GetEntitySpotPos(entity, idx)
GetEntitySpotScale(entity, idx)
GetEntityStepVector(entity, state)
GetEntitySurfacesBBox(entity, request_surfaces, fallback_surfaces, state_idx)
GetExecDirectory()
GetFontDescription(font_id)
GetFontID(font_description)
GetFrameNo()
GetFromClipboard()
GetLanguage()
GetMap()
GetMapBox()
GetMapPath()
GetMirrored()
GetMouseCursor()
GetMultiPathDistances(origin, destinations, pfClass)
GetNumStates()
GetObjects(query)
GetObjectsFromDragRect(classes, firstPoint, secondPoint)
GetPassablePointNearby(pt)
GetPerformanceTime(id)
GetPerformanceTimesMinMax(id)
GetPostProcessingParam(param)
GetPostProcSSAOParam(param)
GetPreciseTicks(precision)
GetProcessorDescription()
GetPStrStats()
GetRandomSpot(entity, state, typeID)
GetRenderStatistics()
GetReverbParameters()
GetRGB(argb)
GetRGBA(argb)
GetSafeArea()
GetSIModulation()
GetSoundDuration(handle_sample_obj)
GetSoundVolume(handle)
GetSpotsType(pchEnt, idx)
GetStateIdx(state)
GetStateMoments(entity, state)
GetStateName(state)
GetStateNameFormat(state)
GetStates(entity)
GetStateSpeedModifier(entity, state)
GetSummonPt(ol, ptCenter, nAreaRadius, pchClass, nRadius, nTries)
GetSurfaces(box, type)
gettablesizes(table)
GetTerrainCursor()
GetTerrainCursorObj(screen_pos)
GetTerrainCursorObjSel(screen_pos)
GetTerrainTextureFiles(layer)
GetTextureFormat(id)
GetTextureId(name)
GetTextureSize(id)
GetThreadStatus(thread)
GetUsername()
GetVar(prefix, name)
GetWalkableObject(pt)
GetWalkableZ(pt)
grid(size, bits)
grid:band(min, max)
grid:clamp(min, max)
grid:convolve(other)
grid:exp(base)
grid:extend(size, a, scale, centered)
grid:fraction(min, max, scale)
grid:get(x, y)
grid:GetBounds(threshold)
grid:IsPointInBounds(x, y)
grid:level(frac)
grid:log(base)
grid:minmax(calc_offset)
grid:normalize()
grid:offset(x, y)
grid:perturb(perturb_x, perturb_y, strength, edge_op)
grid:power(exp)
grid:RasterizeGrid(grid_src, grid_op, raster_options)
grid:RasterizeSegment(p1, p2, callback)
grid:resize(size)
grid:set(x, y, a)
grid:size()
grid:write(filename)
GridExtendOnce(g, up)
Group(list)
HasState(entity, state)
HeightTileSize()
HermiteSpline(p1, m1, p2, m2, t, scale)
HideMouseCursor()
hr.ChangeVideoMode(width, height, refresh, fullscreen, vsync, ignoreMonitorSize)
hr.GetAdapterMode(adapter) --0
hr.GetGpuDeviceID(adapter)
hr.GetHardwareInfo(adapter)
hr.GetNumAdapters()
hr.GetVideoModes(adapter, minWidth, minHeight, bits_vector)
hr.VideoModeChangeStatus()
InterpolateRGB(rgb0, rgb1, p, q)
InterruptAdvance()
IntersectLineCone(pt1, pt2, vertex, dir, angle, height)
IntersectLineWithCircle2D(pt1, pt2, center, radius)
IntersectLineWithLine2D(pt1, pt2, pt3, pt4)
IntersectPolyWithCircle2D(poly, center, radius)
IntersectPolyWithPoly2D(poly1, poly2)
IntersectPolyWithSpline2D(poly, spline, width, precision)
IntersectRayCone(pt1, pt2, vertex, dir, angle, height)
IntersectRayWithSegment2D(origin, dir, pt1, pt2)
IntersectRects(b1, b2)
IntersectSegmentCone(pt1, pt2, vertex, dir, angle, height)
IntersectSegmentCylinder(pt1, pt2, center, radius, height)
IntersectSegmentWithCircle2D(pt1, pt2, center, radius)
IntersectSegmentWithSegment2D(pt1, pt2, pt3, pt4)
InvalidPos()
IsBox(param)
IsCloser(pt, pt1, dist)
IsCloser(pt, pt1, pt2)
IsCloser2D(pt, pt1, dist)
IsCloser2D(pt, pt1, pt2)
IsEntityAnimLooping(entity, anim)
IsErrorState(entity, anim)
IsFlagSet(flags, mask)
IsGameLoading()
IsGameTimeThread(thread)
IsGrid(g)
IsKindOf(object, class)
IsMouseCursorHidden()
IsMoviePlaying()
IsObjInsideCylinder(pt)
IsPassEditSuspended()
IsPoint(pt)
IsPointOverObject()
IsPowerOf2(v)
IsPStr(value)
IsQuaternion(q)
IsQuitInProcess()
IsRealTimeThread(thread)
IsSmaller(pt, length)
IsSmaller(pt1, pt2)
IsSmaller2D(pt, length)
IsSmaller2D(pt1, pt2)
IsSoundLooping(handle_obj_bank)
IsSoundPlaying(handle)
IsThereInternetConnection()
IsValid(obj)
IsValidEntity(entity)
IsValidThread(thread)
len(utf8)
Lengthen(pt, delta_len)
LimitLen(pt, limit)
LoadGame()
maskset(flags, mask, value)
Max(i1, i2)
MemCheckpoint()
Min(i1, i2)
MoveTo(box, pos)
MulDivRound(v, m, d)
MulDivTrunc(v, m, d)
MultiUser.AddNewUser()
MultiUser.DeleteUser()
MultiUser.GetActive()
MultiUser.GetCount()
MultiUser.GetUser(index)
MultiUser.SetActive(index)
MultiUser.SetUser(index, name, country, data1, data2, data3)
nav.ApplyAllObjects()
nav.GenerateMapMesh()
now()
object:AngleToObject(other)
object:AngleToPoint(point)
object:Attach(child, spot)
object:ChangeEntity(newEntity)
object:ClearAnim(channel)
object:ClearEnumFlags(flags)
object:ClearGameFlags(flags)
object:ClearHierarchyEnumFlags(flags)
object:ClearHierarchyGameFlags(flags)
object:Clone()
object:CountAttaches(classes, filter)
object:DestroyAttaches(classes, filter)
object:DestroyRenderObj()
object:Detach()
object:DetachFromMap()
object:Face(pt, time)
object:FindAnimChannel(anim)
object:ForceHiResTextures(bEnable)
object:ForEachAttach(classes, exec)
object:GetAccelerationAndFinalSpeed(destination, starting_speed, time)
object:GetAccelerationAndStartSpeed(destination, final_speed, time)
object:GetAccelerationAndTime(destination, final_speed, starting_speed)
object:GetAllSpotsBeginIndex(state)
object:GetAllSpotsEndIndex(state)
object:GetAngle()
object:GetAnim(channel)
object:GetAnimDebug(channel)
object:GetAnimDuration(state)
object:GetAnimFlags(channel)
object:GetAnimMoment(anim, moment_type, index)
object:GetAnimMomentsCount(anim, moment_type)
object:GetAnimPhase(channel)
object:GetAnimSpeed(channel)
object:GetAnimSpeedModifier()
object:GetAnimStartTime(channel)
object:GetAnimWeight(channel)
object:GetAttach(idx)
object:GetAttaches(classes)
object:GetAttachSpot()
object:GetAxis()
object:GetBSphere()
object:GetColorModifier()
object:GetDestination()
object:GetDestlock()
object:GetDist(other)
object:GetDist2D(other)
object:GetEntityBBox()
object:GetEnumFlags(mask)
object:GetFaceDir(len)
object:GetFrameMark()
object:GetGameFlags(object, mask)
object:GetGravityAngleTime(target, angle, accel)
object:GetGravityFallTime(height, accel)
object:GetGravityHeightTime(target, height, accel)
object:GetHeight()
object:GetMaterialID()
object:GetNearestSpot(state, typeID, pt)
object:GetNumAttaches()
object:GetNumTris()
object:GetNumVertices()
object:GetOpacity()
object:GetOrientation()
object:GetParent()
object:GetParticlesName()
object:GetPlayer()
object:GetPos()
object:GetRadius()
object:GetRandomSpot(state, typeID)
object:GetRandomSpotPos(state, typeID)
object:GetScale()
object:GetSoundPosAndDist()
object:GetSpotAngle(idx)
object:GetSpotBeginIndex(state, typeID)
object:GetSpotEndIndex(state, typeID)
object:GetSpotName(spotID)
object:GetSpotPos(spotID)
object:GetSpotRange(state, typeID)
object:GetSpotRotation(spotID)
object:GetSpotScale(idx)
object:GetSpotVisualPos(spotID)
object:GetState()
object:GetStepLength(stateID)
object:GetStepVector(stateID, direction, phase, duration, step_mod)
object:GetSurfacesBBox(request_surfaces, fallback_surfaces)
object:GetVelocity()
object:GetVelocityVector()
object:GetVisualAngle()
object:GetVisualAxis()
object:GetVisualDist(other)
object:GetVisualDist2D(other)
object:GetVisualPos()
object:GetVisualPos2D()
object:GetVisualPosPrecise()
object:GetWorldScale()
object:GotoFastForward(dst, time)
object:HasAnim(anim)
object:HasEntity()
object:HasSpot(state, typeID)
object:HasState(state)
object:IsAnimLooping(channel)
object:IsGrouped()
object:IsStaticAnim()
object:IsValidPos()
object:IsValidZ()
object:PlayState(nState, count)
object:PredictPos(time, extrapolate)
object:Rotate(this, axis, angle, time)
object:SetAcceleration(accel)
object:SetAngle(angle, time)
object:SetAnim(channel, anim, flags, speed, weight)
object:SetAnimPhase(channel, phase)
object:SetAnimSpeed(channel, speed, time)
object:SetAnimSpeedModifier(modifier)
object:SetAnimStartTime(channel, time)
object:SetAnimWeight(channel, weight, time)
object:SetAxis(axis, time)
object:SetAxisAngle(axis, angle, time)
object:SetColorModifier(argb)
object:SetColorModifier(colorModifier)
object:SetDebugTexture(texture_file)
object:SetEnumFlags(flags)
object:SetGameFlags(flags)
object:SetGravity(accel)
object:SetHierarchyEnumFlags(flags)
object:SetHierarchyGameFlags(flags)
object:SetLocationToObjSpot(this, target_obj, spotidx, time)
object:SetLocationToRandomObjSpot(this, target_obj, spot_type, time)
object:SetLocationToRandomObjStateSpot(this, target_obj, state, spot_type, time)
object:SetMaterialID()
object:SetOpacity(val, time, recursive)
object:SetOrientation(dir, angle, time)
object:SetPlayer(player)
object:SetPos(pos, time)
object:SetScale(scale)
object:SetSound(sound, __type, volume, fade_time, looping)
object:SetSoundVolume(volume, time)
object:SetState(nState)
object:SetStaticFrame(nState, time)
object:StopSound(fade_time)
object:TimeFromAnimStart()
object:TimeToAngleInterpolationEnd()
object:TimeToAnimEnd()
object:TimeToAxisInterpolationEnd()
object:TimeToMoment(channel, moment_type, moment_index)
object:TimeToPosInterpolationEnd()
object:TypeOfMoment(channel, moment_index)
object:VectorTo2D(other)
objlist.__tostring(CommonLua/Core/objlist.lua(681)
objlist.AveragePos(CommonLua/Core/objlist.lua(511)
objlist.AverageVisualPos(CommonLua/Core/objlist.lua(540)
objlist.Clear(CommonLua/Core/objlist.lua(223)
objlist.Contains(CommonLua/Core/objlist.lua(137)
objlist.ContainSameItems(CommonLua/Core/objlist.lua(727)
objlist.Copy(CommonLua/Core/objlist.lua(706)
objlist.Count(CommonLua/Core/objlist.lua(51)
objlist.CountClass(CommonLua/Core/objlist.lua(857)
objlist.Destroy(CommonLua/Core/objlist.lua(834)
objlist.equals(CommonLua/Core/objlist.lua(714)
objlist.FilterClass(CommonLua/Core/objlist.lua(871)
objlist.FilterObjects(CommonLua/Core/objlist.lua(881)
objlist.Find(CommonLua/Core/objlist.lua(68)
objlist.FindClosest(CommonLua/Core/objlist.lua(451)
objlist.FindFirstPredicate(CommonLua/Core/objlist.lua(433)
objlist.FindMax(CommonLua/Core/objlist.lua(406)
objlist.FindMin(CommonLua/Core/objlist.lua(378)
objlist.Fold(CommonLua/Core/objlist.lua(576)
objlist.ForEach(CommonLua/Core/objlist.lua(605)
objlist.GetRandomObj(CommonLua/Core/objlist.lua(746)
objlist.GetRandomObjs(CommonLua/Core/objlist.lua(770)
objlist.Intersection(CommonLua/Core/objlist.lua(296)
objlist.IsTrueForAll(CommonLua/Core/objlist.lua(627)
objlist.IsTrueForAny(CommonLua/Core/objlist.lua(646)
objlist.MaxObject(CommonLua/Core/objlist.lua(476)
objlist.MinObject(CommonLua/Core/objlist.lua(493)
objlist.new(CommonLua/Core/objlist.lua(34)
objlist.print(CommonLua/Core/objlist.lua(697)
objlist.PushBack(CommonLua/Core/objlist.lua(202)
objlist.PushFront(CommonLua/Core/objlist.lua(175)
objlist.RandomObjAsync(CommonLua/Core/objlist.lua(825)
objlist.Remove(CommonLua/Core/objlist.lua(84)
objlist.Reverse(CommonLua/Core/objlist.lua(123)
objlist.SetCommand(CommonLua/Core/objlist.lua(847)
objlist.Shuffle(CommonLua/Core/objlist.lua(59)
objlist.SortBy(CommonLua/Core/objlist.lua(594)
objlist.Sub(CommonLua/Core/objlist.lua(354)
objlist.Subtraction(CommonLua/Core/objlist.lua(326)
objlist.tostring(CommonLua/Core/objlist.lua(681)
objlist.Union(CommonLua/Core/objlist.lua(235)
objlist.UnionMultiple(CommonLua/Core/objlist.lua(266)
objlist.Validate(CommonLua/Core/objlist.lua(666)
Offset(box, offset)
OpenAddress(name)
OpenAndMountSaveFile(filename)
OpenBrowseDialog(initail_dir, file_type, exists)
OutputDebugString(text)
ParticlePlace(filename, pt)
ParticlesReload()
PerformanceTimeAdd(id1, id2)
perlin(size, seed, params, flags, count)
pf.AddTunnel(C)
pf.ChangePathFlags(C)
pf.ClearMoveAnim(C)
pf.DbgDrawFindPath(C)
pf.FilterReachable(C)
pf.ForEachReachable(C)
pf.ForEachReachableDelayed(C)
pf.GetCollisionRadius(C)
pf.GetCurrentPath(C)
pf.GetDebugEnabled(C)
pf.GetDestlockRadius(C)
pf.GetMoveAnim(C)
pf.GetMoveSpeed(C)
pf.GetPath(C)
pf.GetPathFlags(C)
pf.GetPathLen(C)
pf.GetPathPoint(C)
pf.GetPathPointCount(C)
pf.GetPfClass(C)
pf.GetRotationSpeed(C)
pf.GetRotationTime(C)
pf.GetSpeed(C)
pf.GetStepLen(C)
pf.GetTunnel(C)
pf.GetWaitAnim(C)
pf.HasPath(C)
pf.PathEndsBlocked(C)
pf.PathLen(C)
pf.PlaceSample(C)
pf.PlaceSample2(C)
pf.PlaceSample3(C)
pf.PlaceSample4(C)
pf.ReachableGrid(C)
pf.RemoveTunnel(C)
pf.SetCollisionRadius(C)
pf.SetDebugEnabled(C)
pf.SetDestlockRadius(C)
pf.SetMoveAnim(C)
pf.SetMoveSpeed(C)
pf.SetPfClass(C)
pf.SetRotationSpeed(C)
pf.SetRotationTime(C)
pf.SetSpeed(C)
pf.SetStepLen(C)
pf.SetWaitAnim(C)
pf.Step(C)
pf.Stop(C)
pf.UpdateTunnel(C)
PlaceAndInit(class, pos, angle, scale, axis)
PlaceAndInit2(class, posx, posy, posz, angle, scale, axisx, axisy, axisz, state, groupID)
PlaySound(sound, _type, volume, fade_time, looping, point_or_object, loud_distance)
point(x, y, z)
point:Dist(p2)
point:Dist2(p2)
point:Dist2D(p2)
point:Dist2D2(p2)
point:Equal2D(p2)
point:InBox(b)
point:InBox2D(b)
point:InHHex(b)
point:InVHex(b)
point:IsValidZ()
point:Len()
point:Len2()
point:Len2D()
point:Len2D2()
point:SetInvalidZ()
point:SetX()
point:SetY()
point:SetZ()
point:x()
point:y()
point:z()
PrecompileShaders()
procall(f, arg1)
pstr(str, capacity)
pstr:append()
pstr:appendf(fmt)
pstr:appendr(str, count)
pstr:appends(value, str, quote)
pstr:appendt(tbl, indent, as_array)
pstr:appendv(value, indent)
pstr:byte(from, to)
pstr:clear()
pstr:equals(value)
pstr:free()
pstr:reserve(size)
pstr:size()
pstr:str()
pstr:sub(from, to)
quaternion(axis, angle)
quaternion:Dot(q)
quaternion:GetAxisAngle()
quaternion:Inv()
quaternion:Norm()
quit()
RandColor(luminosity)
RandRotation()
RayIntersectsAABB(rayOrg, rayDir, b)
RayIntersectsSphere(rayOrg, rayDir, sphereCenter, sphereRadius)
RealTime()
ResetMemStats()
ResetPerformanceTimes()
ResetProfile(file_name)
Resize(box, size)
ResumePassEdits()
Retreat(utf8, pointer, letters)
RGB(r, g, b)
RGBA(r, g, b, a)
Rotate(pt, angle)
RotateAxis(pt, axis, angle)
RotateRadius(radius, angle, center, return_xyz)
RotateXYZ(x, y, z)
round(number, granularity)
SaveGame()
ScaleBox(box, scalex, scaley, scalez)
ScalePoint(pt, scalex, scaley, scalez)
ScreenToGame(pt)
SegmentIntersectsAABB(pt1, pt2, b)
SegmentIntersectsSphere(pt1, pt2, sphereCenter, sphereRadius)
Serialize()
SerializeAndCompress()
SerializeStr(string_table)
SetA(argb, b)
SetAppMouseCursor(filename)
SetB(argb, b)
SetCameraOffset(x, y)
SetCustomData(index, value)
SetCustomDataString(index1, index2, str)
SetG(argb, g)
SetLen(pt, new_len)
SetPerformanceTimeMarker()
SetPostProcessingParam(param, value, time)
SetPostProcPredicate(name, value)
SetPostProcSSAOParam(param, value)
SetR(argb, r)
SetReverbParameters(params, time)
SetSIModulation(modulation)
SetSoundVolume(handle, volume, time)
SetStateSpeedModifier(modifier)
SetUIMouseCursor(filename)
SetVar(prefix, name, value)
SetWaitMouseCursorFile(filename)
shift(value, shift)
Shorten(pt, delta_len)
ShowMouseCursor()
sin(nAngle)
sizebox()
Sleep(time)
SphereTestSphere(ptCenter11, nRadius1, ptCenter2, nRadius2)
sqrt(nValue)
srp.done_client(C)
srp.done_server(C)
srp.generate_account_data(C)
srp.generate_keys(C)
srp.get_key_verifier(C)
srp.get_params(C)
srp.get_session_key(C)
srp.hash_bin(C)
srp.init_client(C)
srp.init_mod_gen(C)
srp.init_server(C)
srp.random_bits(C)
srp.random_encode64(C)
srp.random_hex(C)
srp.read_conf_info(C)
srp.set_account_data(C)
srp.set_params(C)
srp.set_password(C)
srp.set_username(C)
srp.verify_key(C)
StartMovie(movie_file)
StopMovie()
StopSound(handle)
StretchTextOutline(text, rc, font, color, outline_color, outline_size)
StretchTextShadow(text, rc, font, color, shadow_color, shadow_size, shadow_dir)
string.cmp_lower(str1, str2)
string.ends_with(str, str_to_find, case_insensitive)
string.find_lower(str, str_to_find, start_idx)
string.starts_with(str, str_to_find, case_insensitive)
SuspendPassEdits()
table.clear(t)
table.count(array, field, value)
table.find(array, field, value)
table.iclear(t)
table.icopy(t, deep)
table.iequals(t1, t2)
table.sortby_field(array, field)
table.sortby_field_descending(array, field)
table.weighted_rand(tbl, calc_weight, seed)
tco()
terminal.AddTarget(CommonLua/Core/terminal.lua(10)
terminal.ClearKeysPressed(C)
terminal.GetMousePos()
terminal.GetVKeyNames(C)
terminal.GetWindowsImeCompositionString(C)
terminal.IsKeyPressed(key)
terminal.IsKeyToggled(key)
terminal.IsLRMMouseButtonPressed()
terminal.IsLRMX1X2MouseButtonPressed(C)
terminal.KeyboardEvent(CommonLua/Core/terminal.lua(69)
terminal.MouseEvent(CommonLua/Core/terminal.lua(22)
terminal.RemoveTarget(CommonLua/Core/terminal.lua(18)
terminal.SetOSWindowTitle(text)
terminal.Shortcut(CommonLua/Core/terminal.lua(52)
terminal.SysEvent(CommonLua/Core/terminal.lua(60)
terminal.XEvent(CommonLua/Core/terminal.lua(103)
terrain.ChangeHeight(C)
terrain.ChangeHeightCircle(center, innerRadius, outerRadius, heightdiff)
terrain.ClampPoint(pos, border)
terrain.ClearHeightRestore(C)
terrain.ClearTypeRestore(C)
terrain.CreateImpassableGuardingArea(C)
terrain.DumpMemoryUsed(C)
terrain.FillPassabilityHole(C)
terrain.FindAndFillPassabilityHoles(C)
terrain.FindAndFillTypeHoles(C)
terrain.GetAllTerrainTypes(C)
terrain.GetAreaHeight(pos, radius)
terrain.GetGrassMapHeight()
terrain.GetGrassMapSize()
terrain.GetGrassMapWidth()
terrain.GetHeight(pos)
terrain.GetHeightGrid()
terrain.GetIntersection(pt1, pt2)
terrain.GetMapHeight()
terrain.GetMapSize()
terrain.GetMapWidth()
terrain.GetMaxHeight()
terrain.GetPassGrid()
terrain.GetPassId(C)
terrain.GetSurfaceHeight(pos)
terrain.GetSurfaceNormal(pos)
terrain.GetTerrainNormal(pos)
terrain.GetTerrainsCount(C)
terrain.GetTerrainSlope(C)
terrain.GetTerrainType()
terrain.GetTypeGrid()
terrain.GetTypeGrid(C)
terrain.HashGrids(C)
terrain.HashPassability(C)
terrain.HasRestoreHeight(C)
terrain.HasRestoreType(C)
terrain.HeightMapSize(C)
terrain.HeightTileSize(C)
terrain.ImportHeightMap(C)
terrain.ImportTypeDithered(C)
terrain.InvalidateHeight(C)
terrain.InvalidateType(C)
terrain.IsHeightChanged(C)
terrain.IsPassable(pos)
terrain.IsPointInBounds(C)
terrain.IsPointInBounds(pos, border)
terrain.IsRoad(C)
terrain.IsSCell(C)
terrain.IsVerticalTerrain(pt)
terrain.LinePassable(C)
terrain.PackGrass(area)
terrain.ParallelogramPassable(C)
terrain.PassMapSize(C)
terrain.PassTileSize(C)
terrain.RebuildPassability(C)
terrain.RemapTerrain(C)
terrain.RemapType(remap)
terrain.ResetTerrains(C)
terrain.RestoreHeight(C)
terrain.RestoreType(C)
terrain.RoadTileSize(C)
terrain.Save(C)
terrain.SavePassabilityToTga()
terrain.ScaleHeight(mul, div)
terrain.SetForcedImpassableBox(C)
terrain.SetHeight(C)
terrain.SetHeightAndTypeInLine(C)
terrain.SetHeightCircle(center, innerRadius, outerRadius, height)
terrain.SetHeightGrid(C)
terrain.SetPassability(C)
terrain.SetPassGrid(C)
terrain.SetTerrainType()
terrain.SetTypeCircle(pos, radius, type)
terrain.SetTypeGrid(C)
terrain.SetTypes(C)
terrain.SmoothHeightCircle(center, radius)
terrain.SplinePassable(C)
terrain.TypeMapSize(C)
terrain.TypeTileSize(C)
terrain.UnpackGrass(area)
terrain.UpdateTerrainDebugDraw(C)
TestRaySphere(rayOrg, rayDir, sphereCenter, sphereRadius)
TypeTileSize()
UIL.AreGlyphsValid(C)
UIL.CopyDrawStream(C)
UIL.DbgForceRebuild(C)
UIL.DrawBorderRect(C)
UIL.DrawFrame(C)
UIL.DrawFrameLegacy(C)
UIL.DrawImage(C)
UIL.DrawImageFit(C)
UIL.DrawLine(pt1, pt2, color)
UIL.DrawLineAntialised(C)
UIL.DrawMinimapArrows(C)
UIL.DrawMinimapGameObjects(C)
UIL.DrawSolidRect(C)
UIL.DrawText(C)
UIL.DrawTexture(id, rc, color)
UIL.GetBlendMode(C)
UIL.GetBuildMark(C)
UIL.GetColor(C)
UIL.GetDesaturation(C)
UIL.GetDrawStreamOffset(C)
UIL.GetFont(C)
UIL.GetFontDescription(C)
UIL.GetFontID(C)
UIL.GetImageCacheUsage(C)
UIL.GetOSScreenSize(C)
UIL.GetRenderMark(C)
UIL.GetSafeArea(C)
UIL.GetScreenSize(C)
UIL.HSVtoRGB(C)
UIL.Invalidate(C)
UIL.IsImageReady(C)
UIL.l_dbgDraw(C)
UIL.l_dbgDrawSlots(C)
UIL.l_dbgListUsedSlots(C)
UIL.l_dbgLoad(C)
UIL.l_dbgSlotCount(C)
UIL.l_dbgSlotDesc(C)
UIL.MeasureImage(C)
UIL.MeasureText(C)
UIL.MeasureToCharStart(C)
UIL.ModifiersGetTop()
UIL.ModifiersSetTop(index)
UIL.PopClipRect(C)
UIL.PushClipRect(C)
UIL.PushModifier(params)
UIL.Register(C)
UIL.ReloadImage(C)
UIL.RequestImage(C)
UIL.RGBtoHSV(C)
UIL.SetBlendMode(C)
UIL.SetColor(C)
UIL.SetDesaturation(C)
UIL.SetFont(C)
UIL.SetFontRasterizer(C)
UIL.StretchText(C)
UIL.StretchTextOutline(C)
UIL.StretchTextShadow(C)
UIL.TrimText(C)
UIL.UnloadImage(C)
UIL.UTF8ToUpper(C)
UIL.videoDestroy(C)
UIL.videoDraw(C)
UIL.videoGetCurrentFrame(C)
UIL.videoGetDuration(C)
UIL.videoGetFrameCount(C)
UIL.videoGetSize(C)
UIL.videoNew(C)
UIL.videoPause(C)
UIL.videoPlay(C)
UIL.videoStop(C)
Ungroup(list)
UnmountSaveFile()
Unserialize(str)
UnserializeStr(string_table, str)
UpdateTerrainDebugDraw()
WaitMsg(msg, timeout)
WaitWakeup(timeout)
Wakeup(thread)
WriteScreenshot(file)
XInput.__GetState(controllerId)
XInput.IsControllerConnected(controllerId)
XInput.MaxControllers()
XInput.SetRumble(controllerId, leftSpeed, rightSpeed)
xxhash(arg1, arg2, arg3)
