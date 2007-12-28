let implode chars =
    let s = String.create (List.length chars) in
    let rec loop i = function
        | x :: rest ->
            s.[i] <- x;
            loop (i+1) rest
        | [] ->
            s
    in
    loop 0 chars

let explode s =
    let rec exp i l =
        if i < 0 then l else exp (i - 1) (s.[i] :: l)
    in
    exp (String.length s - 1) []

let rec nnext n acc stream =
    match n with
        | 0 ->
            List.rev acc
        | _ ->
            nnext (n - 1) ((Stream.next stream) :: acc) stream

let float_of_padded_string s =
    try
        let pos = String.index s '0' in
        float_of_string (String.sub s 0 pos)
    with
        Not_found ->
            float_of_string s

let int_of_chars chars =
    List.fold_left
        (fun acc c ->
            (acc lsl 8) lor ((int_of_char c) land 0xFF)
        )
        0
        chars

let int_x_of_chars x chars =
    let full = int_of_chars chars in
    full land ((1 lsl x) - 1)

let int32_of_chars chars =
    (* use logical op to avoid signedness problem *)
    List.fold_left
        (fun acc c ->
            Int32.logor
                (Int32.shift_left acc 8)
                (Int32.logand (Int32.of_int (int_of_char c)) 0xFFl)
        )
        Int32.zero
        chars

let rec chars_of_int v chars n =
    match n > 0 with
        | true ->
            chars_of_int (v / 256) ((char_of_int (v mod 256))::chars) (n - 1)
        | false ->
            if v == 0 then chars else failwith "integer too big"

let rec chars_of_int32 v chars n =
    (* use logical op to avoid signedness problem *)
    match n > 0 with
        | true ->
            chars_of_int32
                (Int32.shift_right_logical v 8)
                ((char_of_int (Int32.to_int (Int32.logand v 0xFFl)))::chars)
                (n - 1)
        | false ->
            if Int32.compare v Int32.zero == 0 then chars else failwith (Printf.sprintf "integer too big? rest=%s" (Int32.to_string v))

let dump_dec str initStr endStr =
    let l = explode str in
    let rec l_to_s chars s =
        match chars with
            | h::t -> l_to_s t (s ^ (string_of_int (int_of_char h)) ^ ",")
            | [] -> s
    in
    (l_to_s l initStr) ^ endStr

let dump_hex str initStr endStr sep =
    let l = explode str in
    let rec l_to_s chars s c =
        match chars with
            | h::t ->
                l_to_s
                    t
                    (Printf.sprintf
                        "%s%.2X%s"
                        s
                        (int_of_char h)
                        c
                    )
                    c
            | [] ->
                s
    in
    (l_to_s l initStr sep) ^ endStr


