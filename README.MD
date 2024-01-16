# What is it?

You are looking at the essense of my PhD.

# matlab_mod_lib

#### Functions

- imfuse_park.m

  - Modified to skip blending black pixels. Used to create figures in the calibration paper.

- pcread_park.m

  - It reads extra fields like colour.

- pcshow_park.m

  - It returns figure handle so that it can delete

- pcdenoise_normal.m

  - point cloud denoise with normal direction

- selectUniformImgSpace

  - It filters input points in the image so that the filtered out put spread uniformly

  



# pose_lib

#### Demo

* quat format : wxyz	

* quat tools

  * inverse

    * inv_quat(q)

  * quat to rotation velocity

    * dq=diff_quat(q');
    * rv = quat2rotvel(dq)/dt;

  * rotvel to quat
    * dq = rotvel2quat((rvel- b)*dt);
    * Start from zero
       * 1qk = cumsum_quat(dq);
    * Start from wq1
       * wq = mul_quat( wq1, 1qk);

  * q(k) = q(k)+dq(k)
    ​	cumsum_quat(dq)

  * transform rot
    * wR1=wRc*cR1
    * wR(1:k)'=wRc*cR(1:k)
    * wqk = mul_quat( wqc, cqk);

  * rotates a vector by a quaternion
    * rvk = Rk*vk
    * rv(1:k) = quat_rotate(q(1:k),vec(1:k))
  * unwrap rotations
    * make the rotation continuous
    * q=unwrap_quat(q)
    * rvel = unwrap_rotvel(rvel)

* 3D pose tools
  * transform pose
    * v0_tq_v = mul_pose3d(v0Tw,w_tq_v);

  * inverse pose
    * v_tq_v0=inv_pose3d(v0_tq_v)

  * trans quat to T
    * T=trans_quat2T(tq) tq=7x1
    * T=trans_quat2T([t;q])



#### Functions

- [$$^ L\textbf{R}_W  {^W\textbf{t}_L} $$] = traj_interpol($\boldsymbol{\xi}$,$\tau_{in}$ ,method ,representation)
  - it support both SE3 and se3 interpolation
  - quaternion and rotvel as well
  - It support for multiple pose interpolation but need some bug fix.
  - Input
    - $^W\boldsymbol{\xi}_L = \begin{bmatrix} \textbf{t}_{3\times n}\\ \textbf{q}_{4\times n} \\  \tau_{1\times n} \end{bmatrix}$ , $^W\boldsymbol{\xi}_L = \begin{bmatrix} \textbf{t}_{3\times n}\\ \textbf{r}_{3\times n} \\  \tau_{1\times n} \end{bmatrix}$ 
    - $$\tau_{in}=\tau_{1\times n}$$
  - Output

$$
{}^{W} \textbf{T}_{L}
:=\begin{bmatrix}
 ^ W\textbf{R}_L& ^W\textbf{t}_L \\ 
\textbf{0} & 1 
\end{bmatrix}
$$



- $^W \textbf{q}_{C,4\times n}$ = inv_quat($^W \textbf{q}_{C,4\times n}$)
- $^G \textbf{q}_{C,4\times n}$ = quat_rotate($^G \textbf{q}_{W,4\times 1}$,$^W \textbf{q}_{C,4\times n}$)
- mul_quat
- cumsum_quat
- ${}^{W} \textbf{T}_{L_k,4 \times 4 \times n}$=trans_quat2T(${}^{W} \boldsymbol{\xi}_{L_k,7 \times n}$)
  - $^W\boldsymbol{\xi}_L = \begin{bmatrix} \textbf{t}_{3\times n}\\ \textbf{q}_{4\times n}  \end{bmatrix}$ 
- ${}^{W} \boldsymbol{\xi}_{L_k,7 \times n}$=T2trans_quat(${}^{W} \textbf{T}_{L_k,4 \times 4 \times n}$)
- mul_pose3d
- ${}^{L_{k}} \boldsymbol{\xi}_{L_{k+1},7 \times n}​$=diff_pose3d(${}^{W} \boldsymbol{\xi}_{L_k,7 \times n}​$)
- ${}^{L_{k}} \textbf{q}_{L_{k+1},4 \times n}$=diff_quat($^W \textbf{q}_{C,4\times n}$)

 

# se3_lib

#### Demo

- run se3_Demo or see html
- run Demo_se3_mean for se3 demo



#### Functions

- $^{W} \textbf{T}_{L}$ = exp_se3($^W\boldsymbol{\xi}_{L,6\times n} $)
  - $^W\boldsymbol{\xi}_L = \begin{bmatrix} \textbf{t}_{3\times 1}\\ \textbf{r}_{3\times 1} \end{bmatrix}$ 
- $^W\boldsymbol{\xi}_L $= log_se3($^{W} \textbf{T}_{L,6\times n}$)
- $^W\boldsymbol{\xi}_{L}$ = mean_se3($^W\boldsymbol{\xi}_{L,6\times n} $)
- $^{W} \boldsymbol{\xi}_C$ = mul_se3($^W\boldsymbol{\xi}_L $,$^L\boldsymbol{\xi}_C $)
- $^{L} \boldsymbol{\xi}_W$ = inv_se3($^W\boldsymbol{\xi}_L $)
- $\boldsymbol{\xi}$=so3r3_to_se3($^W\boldsymbol{\xi}_{so3+R^3,6\times n} $)
  - The translation of $^W\boldsymbol{\xi}_{so3+R^3} $ is not same as se3.
- $[^{L_1}\boldsymbol{\xi}_{L_{2}},^{L_2}\boldsymbol{\xi}_{L_{3}},..... ]$=diff_se3($^W\boldsymbol{\xi}_{L_{1:n},6\times n} $)
- $^{W} \textbf{T}_{L}$ = inv_SE3($^{L} \textbf{T}_{W}$)



